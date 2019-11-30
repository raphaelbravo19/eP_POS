import 'package:encrypt/encrypt.dart';
import 'core.dart';

class Crypto {
  static String encrypt(String plainText) {
    final encrypter = Encrypter(
        AES(Key.fromUtf8(Core().encryptionKey) /*, IV.fromUtf8(Core().iv)*/));
    // AES();

    return encrypter.encrypt(plainText).base64;
  }

  static String decrypt(String cipherText) {
    final encrypter = Encrypter(
        AES(Key.fromUtf8(Core().encryptionKey) /*, , IV.fromUtf8(Core().iv)*/));
    return encrypter.decrypt(Encrypted.fromBase64(cipherText));
  }
}
