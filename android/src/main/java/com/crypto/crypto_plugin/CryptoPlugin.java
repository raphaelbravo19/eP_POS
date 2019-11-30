package io.flutter.plugins.com.crypto.crypto_plugin;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugins.com.crypto.crypto_plugin.EncryptionHelper;



/** CryptoPlugin */
public class CryptoPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "crypto_plugin");
    channel.setMethodCallHandler(new CryptoPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("encrypt")) {
      result.success(EncryptionHelper.encrypt(call.argument("text").toString(),
              call.argument("key").toString(),
              call.argument("iv").toString()));
    } else if (call.method.equals("decrypt")) {
      result.success(EncryptionHelper.decrypt(call.argument("text").toString(),
              call.argument("key").toString(),
              call.argument("iv").toString()));
    } else {
      result.notImplemented();
    }
  }
}

