import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toma_scan/models/sign_in_form_model.dart';
import 'package:toma_scan/models/sign_up_form_model.dart';
import 'package:toma_scan/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:toma_scan/shared/shared_values.dart';

class AuthService {
  // Register
  Future<UserModel> register(SignUpFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/register'),
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

  Future<UserModel> login(SignInFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/login'),
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        // parsing respons secara dinamis
        final responseData = jsonDecode(res.body) as Map<String, dynamic>;

        // mengambil token langsung dari root
        String token = responseData['token'];

        // Mengambil user data dari objek user
        Map<String, dynamic> userData = responseData['user'];

        // membuat instance UserModel
        UserModel user = UserModel.fromJson(({
          ...userData, // Sprean user data
          'token': token, // tambahkan token ke dalam data
        }));

        // Menambahkan password dari form data
        user = user.copyWith(password: data.password);

        // Simpan kredential ke local storage
        await storeCredentialToLocal(user);

        return user;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeCredentialToLocal(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'id', value: user.id.toString());
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
    } catch (e) {
      rethrow;
    }
  }

  // Forgot Password
  Future<String> forgotPassword(String email) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/forgot-password'),
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
        Uri.parse('$baseUrl/verify-otp'),
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
  Future<String> resetPassword(
      String email, String password, String confirmPassword, String otp) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/reset-password'),
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'password': password,
          'password_confirmation': password
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        final responseBody = jsonDecode(res.body);
        print('Response Body: $responseBody'); // Tambahkan log
        return responseBody['message'] ?? 'Password berhasil diubah';
      } else {
        throw jsonDecode(res.body)['message'] ?? 'Terjadi kesalahan';
      }
    } catch (e) {
      print('Error: $e'); // Tambahkan log untuk error
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      // Ambil token dari FlutterSecureStorage
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      // Pastikan token ada sebelum mengirim permintaan logout
      if (token == null) {
        throw 'No token found, user is not logged in.';
      }

      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Kirim token yang didapatkan
        },
      ); // Timeout 10 detik

      if (response.statusCode == 200) {
        // Hapus data kredensial dari local storage setelah logout berhasil
        await clearLocalStorage();
      } else {
        // Menangani status code selain 200
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      // Menampilkan log error yang lebih informatif
      throw 'Logout error: $e';
    }
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
