package com.epaisa.biometric_plugin.helper;

import android.hardware.fingerprint.FingerprintManager;



public interface BiometricsCallback {

    void onAuthenticated(FingerprintManager.CryptoObject cryptoObject);

    void onCancel();

    void onError();
}
