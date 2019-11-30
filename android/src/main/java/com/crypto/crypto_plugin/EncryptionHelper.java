package io.flutter.plugins.com.crypto.crypto_plugin;


import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;


/**
 * EncryptionHelper class used to encrypt and decrypt text it is based on Desede algorithm
 *
 *
 * @author Shaikh Manzoor Ahmed
 * @version 1.0
 * @since 1.0
 */

public class EncryptionHelper {
    private static final String algorithm = "DESede";
    private static final String charSet = "UTF-8";
    private static final String DecryptTransformation = "DESede/CBC/NoPadding";
    private static final String EncryptTransformation = "DESede/CBC/PKCS5Padding";

    /**
     *  Return encrypt text for the give plaintext
     * @param plainText
     * @param key
     * @param initializationVector
     * @return
     */
    public static String encrypt(String plainText,String key,String initializationVector) {
        // ---- Use specified 3DES key and IV from other source --------------
        if (plainText == null)
            plainText = "";
        try {
            Cipher c3des = Cipher.getInstance(EncryptTransformation);
            SecretKeySpec myKey = new SecretKeySpec(key.getBytes(), algorithm);
            IvParameterSpec ivParameterSpec = new IvParameterSpec(initializationVector.getBytes());
            c3des.init(Cipher.ENCRYPT_MODE, myKey, ivParameterSpec);
            byte[] cipherText = c3des.doFinal(plainText.getBytes());
            byte[] bytes = Base64.encode(cipherText);
            return new String(bytes, charSet);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";

    }
    /**
     *  Return plainText
     * @param encryptedText
     * @param key
     * @param initializationVector
     * @return
     */
    public static String decrypt(String encryptedText,String key,String initializationVector) {
        try {
            byte[] keyValue = key.getBytes(charSet);
            byte[] ivValue = initializationVector.getBytes(charSet);
            DESedeKeySpec keySpec = new DESedeKeySpec(keyValue);
            IvParameterSpec iv = new IvParameterSpec(ivValue);
            SecretKey myKey = SecretKeyFactory.getInstance(algorithm).generateSecret(keySpec);
            Cipher cipher = Cipher.getInstance(DecryptTransformation);
            cipher.init(Cipher.DECRYPT_MODE, myKey, iv);
            byte[] input = Base64.decode(deReplaceString(encryptedText).getBytes());
            byte[] encrypted = cipher.doFinal(input);
            return new String(encrypted);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    private static String replaceString(String str) {

        String newString;
        char oldChar = '+';
        char newChar = '-';

        char oldChar1 = '=';
        char newChar1 = ',';

        char oldChar2 = '/';
        char newChar2 = '_';

        int numChar = str.length();
        char[] charArray = new char[numChar];

        str.getChars(0, numChar, charArray, 0);
        int i = 0, flag = 0, j = 0, k = 0;

        while (i < charArray.length) {
            if (charArray[i] == oldChar) {
                charArray[i] = newChar;
                flag = 1;
            }
            i++;
        }
        while (k < charArray.length) {
            if (charArray[k] == oldChar1) {
                charArray[k] = newChar1;
                flag = 1;
            }
            k++;
        }
        while (j < charArray.length) {
            if (charArray[j] == oldChar2) {
                charArray[j] = newChar2;
                flag = 1;
            }
            j++;
        }
        if (flag == 1) {

            newString = new String(charArray);

            return newString;
        }
        return str;
    }


    private static String deReplaceString(String str) {


        String newString;
        char oldChar = '-';
        char newChar = '+';

        char oldChar1 = ',';
        char newChar1 = '=';

        char oldChar2 = '_';
        char newChar2 = '/';

        int numChar = str.length();
        char[] charArray = new char[numChar];

        str.getChars(0, numChar, charArray, 0);
        int i = 0, flag = 0, j = 0, k = 0;

        while (i < charArray.length) {
            if (charArray[i] == oldChar) {
                charArray[i] = newChar;
                flag = 1;
            }
            i++;
        }
        while (k < charArray.length) {
            if (charArray[k] == oldChar1) {
                charArray[k] = newChar1;
                flag = 1;
            }
            k++;
        }
        while (j < charArray.length) {
            if (charArray[j] == oldChar2) {
                charArray[j] = newChar2;
                flag = 1;
            }
            j++;
        }
        if (flag == 1) {

            newString = new String(charArray);

            return newString;
        }
        return str;
    }



}
