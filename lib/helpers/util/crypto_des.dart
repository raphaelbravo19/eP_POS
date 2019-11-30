import '../crypto_plugin/crypto_plugin.dart';
import 'core.dart';

class Crypto {
  static Future<String> encrypt(String plainText) async {
    String cipherText =
        await CryptoPlugin.encrypt(plainText, Core().encryptionKey, Core().iv);
    return cipherText;
  }

  static Future<String> decrypt(String cipherText) async {
    String plainText =
        await CryptoPlugin.decrypt(cipherText, Core().encryptionKey, Core().iv);
    return plainText;
  }

  static Future<String> encryptWithCustomKey(
      String plainText, String key, String iv) async {
    String cipherText = await CryptoPlugin.encrypt(plainText, key, iv);
    return cipherText;
  }

  static Future<String> decryptWithCustomKey(
      String cipherText, String key, String iv) async {
    String plainText = await CryptoPlugin.decrypt(cipherText, key, iv);
    return plainText;
  }
}
