import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toma_scan/models/user_model.dart'; // Import User model

class UserService {
  final String apiUrl;

  UserService({required this.apiUrl});

  // HTTP POST request untuk Sign Up
  Future<User> signUp(String email, String password) async {
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
      return User.fromJson(
          jsonDecode(response.body)); // Mengubah response menjadi objek User
    } else {
      throw Exception('Failed to sign up'); // Error handling jika gagal
    }
  }

  // HTTP POST request untuk Sign In
  Future<User> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/sign_in'), // Endpoint untuk sign in
      headers: <String, String>{
        'Content-Type': 'application/json', // Header untuk data JSON
      },
      body: jsonEncode({
        'email': email, // Data body untuk login
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Jika status code 200, berarti berhasil
      return User.fromJson(
          jsonDecode(response.body)); // Mengubah response menjadi objek User
    } else {
      throw Exception('Failed to sign in'); // Error handling jika gagal
    }
  }

  // HTTP POST request untuk Sign Out
  Future<void> signOut() async {
    // Biasanya logout hanya melibatkan penghapusan token atau sesi
    // Anda dapat menyesuaikan dengan logika sign out di aplikasi
  }
}
