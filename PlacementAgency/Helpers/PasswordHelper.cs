using System;
using System.Security.Cryptography;

namespace PlacementAgency.Helpers
{
    public static class PasswordHelper
    {
        // Generate strong salt
        public static byte[] GenerateSalt(int size = 32)
        {
            byte[] saltBytes = new byte[size];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(saltBytes);
            }
            return saltBytes;
        }

        // Hash password using PBKDF2
        public static byte[] HashPassword(string password, byte[] salt)
        {
            using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 10000))
            {
                return pbkdf2.GetBytes(32);
            }
        }

        // Compare hashes (timing-safe)
        public static bool VerifyPassword(string enteredPassword, byte[] storedSalt, byte[] storedHash)
        {
            byte[] enteredHash = HashPassword(enteredPassword, storedSalt);
            return SlowEquals(enteredHash, storedHash);
        }

        private static bool SlowEquals(byte[] a, byte[] b)
        {
            uint diff = (uint)a.Length ^ (uint)b.Length;
            for (int i = 0; i < a.Length && i < b.Length; i++)
            {
                diff |= (uint)(a[i] ^ b[i]);
            }
            return diff == 0;
        }
    }
}
