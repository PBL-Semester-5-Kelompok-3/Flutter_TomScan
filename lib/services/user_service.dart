import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toma_scan/models/user_model.dart';

class UserService {
  final String apiUrl;

  UserService({required this.apiUrl});

  Future<User> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/sign_up'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<User> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/sign_in'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<void> signOut() async {
    // Logic to handle sign-out
    // You might clear local session or token here
  }
}
