using System;
using System.Text;
using System.Security.Cryptography;

class Program
{
    static void Main()
    {
        string input = "Hola mundo";
        string hash = ComputeSha256Hash(input);
        Console.WriteLine($"SHA-256: {hash}");
    }

    static string ComputeSha256Hash(string rawData)
    {
        using (SHA256 sha256Hash = SHA256.Create())
        {
            // Convertir a bytes y calcular hash
            byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));

            // Convertir a string hexadecimal
            StringBuilder builder = new StringBuilder();
            foreach (var b in bytes)
                builder.Append(b.ToString("x2"));

            return builder.ToString();
        }
    }
}
