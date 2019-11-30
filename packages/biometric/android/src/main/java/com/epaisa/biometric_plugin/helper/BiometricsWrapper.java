package com.epaisa.biometric_plugin.helper;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.KeyguardManager;
import android.content.Context;
import android.hardware.fingerprint.FingerprintManager;
import android.os.Build;
import android.security.keystore.KeyGenParameterSpec;
import android.security.keystore.KeyProperties;
import android.text.TextUtils;
import android.util.Base64;

import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.security.spec.RSAKeyGenParameterSpec;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by brandon on 4/5/18.
 */

public class BiometricsWrapper {

    private String biometricKeyAlias = "biometric_key";
    private Activity activity;

    public BiometricsWrapper(Activity activity) {
        this.activity = activity;
    }

    public void isSensorAvailable(BioMetricWrapperCallback callback) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {

                FingerprintManager fingerprintManager = activity.getSystemService(FingerprintManager.class);
                Boolean isHardwareDetected = fingerprintManager.isHardwareDetected();
                Boolean hasFingerprints = fingerprintManager.hasEnrolledFingerprints();

                KeyguardManager keyguardManager = (KeyguardManager) activity.getSystemService(Context.KEYGUARD_SERVICE);
                Boolean hasProtectedLockscreen = keyguardManager.isKeyguardSecure();

                if (isHardwareDetected && hasFingerprints && hasProtectedLockscreen) {
                    Map<String, String> response = new HashMap<>();
                    response.put("status", "success");
                    response.put("sensorAvailable", "TouchID");
                    callback.onResponse(response);
                } else {
                    Util.buildFailureResponse("Sensor not available");
                }
            } else {
                Util.buildFailureResponse("Sensor not available");
            }
        } catch (Exception e) {
            Util.buildFailureResponse("Error detecting fingerprint availability: " + e.getMessage());
        }
    }


    public void createKeys(String title, BioMetricWrapperCallback callback) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                if (TextUtils.isEmpty(title)) {
                    // if no title is provided for the create keys prompt, treat the action as
                    // authenticated and create keys
                    BiometricsCallback createKeysCallback = getCreationCallback(callback);
                    createKeysCallback.onAuthenticated(null);
                } else {
                    BiometricsDialog dialog = new BiometricsDialog();
                    dialog.init(title, null, getCreationCallback(callback));
                    dialog.show(activity.getFragmentManager(), "fingerprint_dialog");
                }
            } else {
                callback.onResponse(Util.buildFailureResponse("Cannot generate keys on android versions below 6.0"));
            }
        } catch (Exception e) {
            callback.onResponse(Util.buildFailureResponse("Error generating public private keys: " + e.getMessage()));
        }
    }


    public void deleteKeys(BioMetricWrapperCallback callback) {
        if (biometricKeyExists()) {
            boolean deletionSuccessful = deleteBiometricKey();

            if (deletionSuccessful) {
                Map<String, String> response = new HashMap<>();
                response.put("status", "success");
                response.put("keysDeleted", "true");
                callback.onResponse(response);
            } else {
                callback.onResponse(Util.buildFailureResponse("Error deleting biometric key from keystore"));
            }
        } else {
            Map<String, String> response = new HashMap<>();
            response.put("status", "failure");
            response.put("keysDeleted", "false");
            callback.onResponse(response);
        }
    }


    public void createSignature(String title, String payload, BioMetricWrapperCallback callback) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                Signature signature = Signature.getInstance("SHA256withRSA");
                KeyStore keyStore = KeyStore.getInstance("AndroidKeyStore");
                keyStore.load(null);

                PrivateKey privateKey = (PrivateKey) keyStore.getKey(biometricKeyAlias, null);
                signature.initSign(privateKey);

                FingerprintManager.CryptoObject cryptoObject = new FingerprintManager.CryptoObject(signature);

                BiometricsDialog dialog = new BiometricsDialog();
                dialog.init(title, cryptoObject, getSignatureCallback(payload, callback));

                dialog.show(activity.getFragmentManager(), "fingerprint_dialog");
            } else {
                callback.onResponse(Util.buildFailureResponse("Cannot generate keys on android versions below 6.0"));
            }
        } catch (Exception e) {
            callback.onResponse(Util.buildFailureResponse("Error signing payload: " + e.getMessage()));
        }
    }


    public void simplePrompt(String title, BioMetricWrapperCallback callback) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                BiometricsDialog dialog = new BiometricsDialog();
                dialog.init(title, null, getSimplePromptCallback(callback));
                dialog.show(activity.getFragmentManager(), "fingerprint_dialog");
            } else {
                callback.onResponse(Util.buildFailureResponse("Cannot display biometric prompt on android versions below 6.0"));

            }
        } catch (Exception e) {
            callback.onResponse(Util.buildFailureResponse("Error displaying local biometric prompt: " + e.getMessage()));

        }
    }


    private boolean biometricKeyExists() {
        try {
            KeyStore keyStore = KeyStore.getInstance("AndroidKeyStore");
            keyStore.load(null);

            return keyStore.containsAlias(biometricKeyAlias);
        } catch (Exception e) {
            return false;
        }
    }

    private boolean deleteBiometricKey() {
        try {
            KeyStore keyStore = KeyStore.getInstance("AndroidKeyStore");
            keyStore.load(null);

            keyStore.deleteEntry(biometricKeyAlias);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    private BiometricsCallback getSignatureCallback(final String payload, final BioMetricWrapperCallback callback) {
        return new BiometricsCallback() {
            @Override
            @TargetApi(Build.VERSION_CODES.M)
            public void onAuthenticated(FingerprintManager.CryptoObject cryptoObject) {
                try {
                    Signature cryptoSignature = cryptoObject.getSignature();
                    cryptoSignature.update(payload.getBytes());
                    byte[] signed = cryptoSignature.sign();
                    String signedString = Base64.encodeToString(signed, Base64.DEFAULT);
                    signedString = signedString.replaceAll("\r", "").replaceAll("\n", "");
                    Map<String, String> response = new HashMap<>();
                    response.put("status", "success");
                    response.put("signedSignature", signedString);
                    callback.onResponse(response);
                } catch (Exception e) {
                    callback.onResponse(Util.buildFailureResponse("Error creating signature"));
                }
            }

            @Override
            public void onCancel() {
                callback.onResponse(Util.buildFailureResponse("User cancelled fingerprint authorization"));
            }

            @Override
            public void onError() {
                callback.onResponse(Util.buildFailureResponse("Error generating public private keys"));
            }
        };
    }

    private BiometricsCallback getCreationCallback(final BioMetricWrapperCallback callback) {
        return new BiometricsCallback() {
            @Override
            @TargetApi(Build.VERSION_CODES.M)
            public void onAuthenticated(FingerprintManager.CryptoObject cryptoObject) {
                try {
                    deleteBiometricKey();
                    KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(KeyProperties.KEY_ALGORITHM_RSA, "AndroidKeyStore");
                    KeyGenParameterSpec keyGenParameterSpec = new KeyGenParameterSpec.Builder(biometricKeyAlias, KeyProperties.PURPOSE_SIGN)
                            .setDigests(KeyProperties.DIGEST_SHA256)
                            .setSignaturePaddings(KeyProperties.SIGNATURE_PADDING_RSA_PKCS1)
                            .setAlgorithmParameterSpec(new RSAKeyGenParameterSpec(2048, RSAKeyGenParameterSpec.F4))
                            .setUserAuthenticationRequired(true)
                            .build();
                    keyPairGenerator.initialize(keyGenParameterSpec);

                    KeyPair keyPair = keyPairGenerator.generateKeyPair();
                    PublicKey publicKey = keyPair.getPublic();
                    byte[] encodedPublicKey = publicKey.getEncoded();
                    String publicKeyString = Base64.encodeToString(encodedPublicKey, Base64.DEFAULT);
                    publicKeyString = publicKeyString.replaceAll("\r", "").replaceAll("\n", "");
                    Map<String, String> response = new HashMap<>();
                    response.put("status", "success");
                    response.put("publicKey", publicKeyString);
                    callback.onResponse(response);
                } catch (Exception e) {
                    callback.onResponse(Util.buildFailureResponse("Error generating public private keys: " + e.getMessage()));
                }
            }

            @Override
            public void onCancel() {
                callback.onResponse(Util.buildFailureResponse("User cancelled fingerprint authorization"));
            }

            @Override
            public void onError() {
                callback.onResponse(Util.buildFailureResponse("Error generating public private keys"));
            }
        };
    }

    private BiometricsCallback getSimplePromptCallback(final BioMetricWrapperCallback callback) {
        return new BiometricsCallback() {
            @Override
            public void onAuthenticated(FingerprintManager.CryptoObject cryptoObject) {
                Map<String, String> response = new HashMap<>();
                response.put("status", "success");
                response.put("authenticated", "true");
                callback.onResponse(response);
            }

            @Override
            public void onCancel() {
                callback.onResponse(Util.buildFailureResponse("User cancelled fingerprint authorization"));
            }

            @Override
            public void onError() {
                callback.onResponse(Util.buildFailureResponse("Error generating public private keys"));
            }
        };
    }
}
