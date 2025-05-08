using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

class Program
{
    static void Main()
    {
        string plainText = "Hello, World!";
        Console.WriteLine($"Original Text: {plainText}\n");

        // DES
        using (DESCryptoServiceProvider des = new DESCryptoServiceProvider())
        {
            Console.WriteLine("DES");
            var encrypted = Encrypt(plainText, des.CreateEncryptor(des.Key, des.IV));
            var decrypted = Decrypt(encrypted, des.CreateDecryptor(des.Key, des.IV));
            Show(encrypted, decrypted);
        }

        // TripleDES
        using (TripleDESCryptoServiceProvider tripleDes = new TripleDESCryptoServiceProvider())
        {
            Console.WriteLine("TripleDES");
            var encrypted = Encrypt(plainText, tripleDes.CreateEncryptor(tripleDes.Key, tripleDes.IV));
            var decrypted = Decrypt(encrypted, tripleDes.CreateDecryptor(tripleDes.Key, tripleDes.IV));
            Show(encrypted, decrypted);
        }

        // AES
        using (Aes aes = Aes.Create())
        {
            Console.WriteLine("AES");
            var encrypted = Encrypt(plainText, aes.CreateEncryptor(aes.Key, aes.IV));
            var decrypted = Decrypt(encrypted, aes.CreateDecryptor(aes.Key, aes.IV));
            Show(encrypted, decrypted);
        }

        // RSA
        using (RSA rsa = RSA.Create())
        {
            Console.WriteLine("RSA");
            byte[] encrypted = rsa.Encrypt(Encoding.UTF8.GetBytes(plainText), RSAEncryptionPadding.Pkcs1);
            byte[] decrypted = rsa.Decrypt(encrypted, RSAEncryptionPadding.Pkcs1);
            Console.WriteLine($"Encrypted (Base64): {Convert.ToBase64String(encrypted)}");
            Console.WriteLine($"Decrypted: {Encoding.UTF8.GetString(decrypted)}\n");
        }

        // SHA256
        using (SHA256 sha256 = SHA256.Create())
        {
            Console.WriteLine("SHA256 (Hash)");
            byte[] hash = sha256.ComputeHash(Encoding.UTF8.GetBytes(plainText));
            Console.WriteLine($"Hashed (Base64): {Convert.ToBase64String(hash)}\n");
        }
    }

    static byte[] Encrypt(string plainText, ICryptoTransform encryptor)
    {
        using MemoryStream ms = new();
        using CryptoStream cs = new(ms, encryptor, CryptoStreamMode.Write);
        using StreamWriter sw = new(cs);
        sw.Write(plainText);
        sw.Close();
        return ms.ToArray();
    }

    static string Decrypt(byte[] cipherText, ICryptoTransform decryptor)
    {
        using MemoryStream ms = new(cipherText);
        using CryptoStream cs = new(ms, decryptor, CryptoStreamMode.Read);
        using StreamReader sr = new(cs);
        return sr.ReadToEnd();
    }

    static void Show(byte[] encrypted, string decrypted)
    {
        Console.WriteLine($"Encrypted (Base64): {Convert.ToBase64String(encrypted)}");
        Console.WriteLine($"Decrypted: {decrypted}\n");
    }
}

