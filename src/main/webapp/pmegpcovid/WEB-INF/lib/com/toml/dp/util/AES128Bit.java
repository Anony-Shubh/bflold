package com.toml.dp.util;

import javax.crypto.SecretKey;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.SecretKeySpec;
import java.security.Key;
import javax.crypto.Cipher;

public class AES128Bit
{
    private static final String ALGORITHM = "AES";
    
    public static String encrypt(final String valueToEnc, final String secretKey) {
        String encryptedValue = null;
        try {
            final Key key = generateKeyFromString(secretKey);
            final Cipher c = Cipher.getInstance("AES");
            c.init(1, key);
            final byte[] encValue = c.doFinal(valueToEnc.getBytes());
            encryptedValue = new String(DPBase64Coder.encode(encValue));
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return encryptedValue;
    }
    
    public static String decrypt(final String encryptedValue, final String secretKey) {
        String decryptedValue = null;
        try {
            final Key key = generateKeyFromString(secretKey);
            final Cipher c = Cipher.getInstance("AES");
            c.init(2, key);
            final byte[] decordedValue = DPBase64Coder.decode(encryptedValue);
            final byte[] decValue = c.doFinal(decordedValue);
            decryptedValue = new String(decValue);
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return decryptedValue;
    }
    
    private static Key generateKeyFromString(final String secretKey) throws Exception {
        final byte[] keyValue = DPBase64Coder.decode(secretKey);
        final Key key = new SecretKeySpec(keyValue, "AES");
        return key;
    }
    
    public static String generateNewKey() {
        String newKey = null;
        try {
            final KeyGenerator kgen = KeyGenerator.getInstance("AES");
            kgen.init(128);
            final SecretKey skey = kgen.generateKey();
            final byte[] raw = skey.getEncoded();
            newKey = new String(DPBase64Coder.encode(raw));
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return newKey;
    }
    
    /*
    public static void main(final String[] args) {
        final String password = "kvicsbiepaydit";
        final String passwordEnc = encrypt(password, "glBv+xevOenDM5ydcqb9pA==");
        final String passwordDec = decrypt(passwordEnc, "glBv+xevOenDM5ydcqb9pA==");
        System.out.println("Plain Text: " + password);
        System.out.println("Encrypted: " + passwordEnc);
        System.out.println("Decrypted: " + passwordDec);
    }
    */
}