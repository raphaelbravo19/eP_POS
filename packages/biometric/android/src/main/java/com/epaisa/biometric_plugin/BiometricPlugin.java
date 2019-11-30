package com.epaisa.biometric_plugin;

import android.app.Activity;

import com.epaisa.biometric_plugin.helper.BioMetricWrapperCallback;
import com.epaisa.biometric_plugin.helper.BiometricsWrapper;

import java.util.Map;
import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

public class BiometricPlugin implements MethodCallHandler {
    private Activity activity;

    public BiometricPlugin(Activity activity) {
        this.activity = activity;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(PluginRegistry.Registrar registrar) {

        final MethodChannel channel = new MethodChannel(registrar.messenger(), "biometric_plugin");
        channel.setMethodCallHandler(new BiometricPlugin(registrar.activity()));
    }

    @Override
    public void onMethodCall(MethodCall call, final Result result) {
        switch (call.method) {
            case "isSensorAvailable": {
                BiometricsWrapper wrapper = new BiometricsWrapper(activity);
                wrapper.isSensorAvailable(new BioMetricWrapperCallback() {
                    @Override
                    public void onResponse(Map<String, String> response) {
                        result.success(response);
                    }
                });
                break;
            }
            case "createKeys": {
                BiometricsWrapper wrapper = new BiometricsWrapper(activity);
                wrapper.createKeys((String) call.argument("title"), new BioMetricWrapperCallback() {
                    @Override
                    public void onResponse(Map<String, String> response) {
                        result.success(response);
                    }
                });
                break;
            }
            case "deleteKeys": {
                BiometricsWrapper wrapper = new BiometricsWrapper(activity);
                wrapper.deleteKeys(new BioMetricWrapperCallback() {
                    @Override
                    public void onResponse(Map<String, String> response) {
                        result.success(response);
                    }
                });
                break;
            }
            case "createSignature": {
                BiometricsWrapper wrapper = new BiometricsWrapper(activity);
                wrapper.createSignature((String) call.argument("title"), (String) call.argument("payload"), new BioMetricWrapperCallback() {
                    @Override
                    public void onResponse(Map<String, String> response) {
                        result.success(response);
                    }
                });
                break;
            }
            case "simplePrompt": {
                BiometricsWrapper wrapper = new BiometricsWrapper(activity);
                wrapper.simplePrompt((String) call.argument("title"), new BioMetricWrapperCallback() {
                    @Override
                    public void onResponse(Map<String, String> response) {
                        result.success(response);
                    }
                });
                break;
            }
            default:
                result.notImplemented();
                break;
        }
    }
}
