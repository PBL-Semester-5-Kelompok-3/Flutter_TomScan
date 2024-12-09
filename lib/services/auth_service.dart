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

      if (res.statusCode == 200) {
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

  login(SignInFormModel data) {}

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
}
