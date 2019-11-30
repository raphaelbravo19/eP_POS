// import 'dart:convert';
import 'dart:convert';
import 'package:encrypt/encrypt.dart';

class EncryptHelper {
  // static String _key = 'o/49PoDibUe0qJiuSRjMUJkJS/hUwVfO3h0NBw9br9c=';
  // static String _iv = 'grnKko3EL4KiELhHKG2Gj7At2XfbA4twv3LKNA4cBVQ=';
  test() {
    final secret = '123456789012345678901234567890ce';
    final secretiv = '1234567890carlos';
    final key = Key.fromUtf8(secret);
    final iv = IV.fromUtf8(secretiv);
    // final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final decode = utf8.decode(base64.decode('8iaK8hPAtXJt3QrijsGXWA=='));
    // final encrypted = encrypter.encrypt('frao', iv: iv);
    // final encrypted = Encrypted.fromUtf8(decode);
    print('decode $decode');

    // final decrypted = encrypter.decrypt(
    //   encrypted,
    //   iv: iv,
    // );
    // print('decrypted $decrypted');
    // print('key ${key.base64}');
    // print('iv ${iv.base64}');
    // print('decrypted: $decrypted');
    // print('encrypted: ${encrypted.base64}');
  }
}
