package System;

public class EncryptionManual {

    public static void main(String[] args) {
        String plainPassword = "ADMIN123";
        String encrypted = EncryptionFunction.encrypt(plainPassword);

        System.out.println("Password Asli : " + plainPassword);
        System.out.println("Encrypted     : " + encrypted);
    }
}