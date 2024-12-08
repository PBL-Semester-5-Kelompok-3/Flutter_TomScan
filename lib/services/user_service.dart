// lib/services/user_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String apiUrl;

  UserService({required this.apiUrl});

  // HTTP POST request untuk Sign Up
  Future<Map<String, dynamic>> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/sign_up'), // Endpoint untuk sign up
      headers: <String, String>{
        'Content-Type': 'application/json', // Header untuk data JSON
      },
      body: jsonEncode({
        'email': email, // Data body untuk sign up
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Jika status code 200, berarti berhasil
      return jsonDecode(response.body); // Mengambil response sebagai Map
    } else {
      throw Exception('Failed to sign up');
    }
  }

  // HTTP POST request untuk Sign In
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/sign_in'), // Endpoint untuk sign in
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign in');
    }
  }

  // Menambahkan metode sendOtpToEmail
  Future<bool> sendOtpToEmail(String email) async {
    final response = await http.post(
      Uri.parse('$apiUrl/forgot_password'), // Endpoint untuk forgot password
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email, // Mengirim email untuk mengirimkan OTP
      }),
    );

    if (response.statusCode == 200) {
      // Jika status code 200, berarti OTP berhasil dikirim
      return true;
    } else {
      // Jika gagal, lempar exception atau return false
      throw Exception('Failed to send OTP');
    }
  }

  // HTTP POST request untuk Reset Password setelah OTP berhasil diverifikasi
  Future<void> resetPassword(String email, String newPassword) async {
    final response = await http.post(
      Uri.parse('$apiUrl/reset_password'), // Endpoint untuk reset password
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email, // Email pengguna yang ingin direset passwordnya
        'new_password': newPassword, // Password baru yang akan diset
      }),
    );

    if (response.statusCode == 200) {
      // Password berhasil direset
    } else {
      throw Exception('Failed to reset password');
    }
  }

  signOut() {}
}
