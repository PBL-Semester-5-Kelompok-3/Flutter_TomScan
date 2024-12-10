import 'dart:convert';
import 'package:toma_scan/models/sign_in_form_model.dart';
import 'package:toma_scan/models/sign_up_form_model.dart';
import 'package:toma_scan/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Register
  Future<UserModel> register(SignUpFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('https://tomascan.nurulmustofa.my.id/api/register'),
        body: data.toJson(),
      );

      if (res.statusCode == 201) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));
        user = user.copyWith(password: data.password);
        return user;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // Login
  Future<UserModel> login(SignInFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('https://tomascan.nurulmustofa.my.id/api/login'),
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));
        return user;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // Forgot Password
  Future<String> forgotPassword(String email) async {
    try {
      final res = await http.post(
        Uri.parse('https://tomascan.nurulmustofa.my.id/api/forgot-password'),
        body: jsonEncode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        final responseBody = jsonDecode(res.body);
        return responseBody['message'] ??
            'Tautan reset password telah dikirim.';
      } else {
        throw jsonDecode(res.body)['message'] ?? 'Terjadi kesalahan';
      }
    } catch (e) {
      rethrow;
    }
  }

  //Verify OTP
  Future<String> verifyOTP(String email, String otp) async {
    try {
      final res = await http.post(
        Uri.parse('https://tomascan.nurulmustofa.my.id/api/verify-otp'),
        body: jsonEncode({'email': email, 'otp': otp}),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        final responseBody = jsonDecode(res.body);
        return responseBody['message'] ?? 'Kode OTP tidak valid';
      } else {
        throw jsonDecode(res.body)['message'] ?? 'Terjadi kesalahan';
      }
    } catch (e) {
      rethrow;
    }
  }

  // Reset Password
  Future<String> resetPassword(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('https://tomascan.nurulmustofa.my.id/api/reset-password'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        final responseBody = jsonDecode(res.body);
        return responseBody['message'] ?? 'Password berhasil diubah';
      } else {
        throw jsonDecode(res.body)['message'] ?? 'Terjadi kesalahan';
      }
    } catch (e) {
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      final response = await http.post(
        Uri.parse('https://tomascan.nurulmustofa.my.id/api/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_ACCESS_TOKEN', // Jika diperlukan
        },
      ).timeout(const Duration(seconds: 10)); // Timeout 10 detik

      if (response.statusCode == 200) {
        if (response.body == 'Successfully logged out') {
          return;
        } else {
          throw 'Unexpected response: ${response.body}';
        }
      } else {
        throw 'Logout failed with status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Logout error: $e';
    }
  }
}
