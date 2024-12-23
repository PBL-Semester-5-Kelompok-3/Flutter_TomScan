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
      // Baca data lama jika ada
      String? token = await storage.read(key: 'token');
      String? id = await storage.read(key: 'id');
      String? email = await storage.read(key: 'email');
      String? username = await storage.read(key: 'username');
      String? password = await storage.read(key: 'password');

      // Tulis data baru atau gunakan data lama jika null
      await storage.write(key: 'token', value: user.token ?? token);
      await storage.write(key: 'id', value: user.id?.toString() ?? id);
      await storage.write(key: 'username', value: user.username ?? username);
      await storage.write(key: 'email', value: user.email ?? email);
      await storage.write(key: 'password', value: user.password ?? password);
    } catch (e) {
      rethrow;
    }
  }

  // View Profile
  Future<UserModel> getProfile() async {
    try {
      // Ambil token dari FlutterSecureStorage
      const storage = FlutterSecureStorage();
      String? token = await storage.read(
        key: 'token',
      );
      String? username = await storage.read(
        key: 'username',
      );
      String? email = await storage.read(
        key: 'email',
      );
      String? password = await storage.read(
        key: 'password',
      );

      // Pastikan token ada sebelum mengirim permintaan
      if (token == null) {
        throw 'No token found, user is not logged in.';
      }

      // Mengirim permintaan GET untuk mengambil data profil pengguna
      final res = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Authorization':
              'Bearer $token', // Kirim token dalam header Authorization
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        final responseData = jsonDecode(res.body) as Map<String, dynamic>;

        // Ambil data user dari response
        Map<String, dynamic> userData = responseData['user'];

        // Membuat instance UserModel
        UserModel user = UserModel.fromJson(userData);

        // Menyimpan profil pengguna ke dalam local storage
        await storeCredentialToLocal(user);

        return user;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // Update Username
  Future<UserModel> updateUsername(String username) async {
    try {
      // Ambil token dari secure storage
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      if (token == null) {
        throw 'No token found, user is not logged in.';
      }

      // Kirim permintaan untuk memperbarui username
      final response = await http.put(
        Uri.parse('$baseUrl/update-username'), // Endpoint untuk update username
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'username': username}),
      );

      if (response.statusCode == 200) {
        // Parsing response body
        final responseData = jsonDecode(response.body);
        UserModel updatedUser = UserModel.fromJson(responseData['user']);

        // Simpan ke local storage
        await storeCredentialToLocal(updatedUser);

        return updatedUser;
      } else {
        throw jsonDecode(response.body)['message'] ??
            'Failed to update username';
      }
    } catch (e) {
      rethrow;
    }
  }

// Update Password
  Future<UserModel> updatePassword(String password) async {
    try {
      // Ambil token dari secure storage
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      if (token == null) {
        throw 'No token found, user is not logged in.';
      }

      // Kirim permintaan untuk memperbarui password
      final response = await http.put(
        Uri.parse('$baseUrl/update-password'), // Endpoint untuk update password
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'password': password}),
      );

      if (response.statusCode == 200) {
        // Parsing response body
        final responseData = jsonDecode(response.body);
        UserModel updatedUser = UserModel.fromJson(responseData['user']);

        // Simpan ke local storage
        await storeCredentialToLocal(updatedUser);

        return updatedUser;
      } else {
        throw jsonDecode(response.body)['message'] ??
            'Failed to update password';
      }
    } catch (e) {
      rethrow;
    }
  }

// Update Profile (Username dan Password)
  Future<UserModel> updateProfile({String? username, String? password}) async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      if (token == null) {
        throw Exception('No token found, user is not logged in.');
      }

      final Uri endpoint;
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final Map<String, dynamic> body = {};

      if (username != null && password == null) {
        endpoint = Uri.parse('$baseUrl/update-username');
        body['username'] = username;
      } else if (password != null && username == null) {
        endpoint = Uri.parse('$baseUrl/update-password');
        body['password'] = password;
      } else if (username != null && password != null) {
        endpoint = Uri.parse('$baseUrl/update-profile');
        body['username'] = username;
        body['password'] = password;
      } else {
        throw Exception('No changes were made to the profile.');
      }

      final response = await http.put(
        endpoint,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final UserModel updatedUser = UserModel.fromJson(responseData['user']);
        await storeCredentialToLocal(updatedUser);
        return updatedUser;
      } else {
        final error =
            jsonDecode(response.body)['message'] ?? 'Failed to update profile';
        throw Exception(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> editProfile(UserModel updatedUser) async {
    try {
      // Ambil token dari secure storage
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      if (token == null) {
        throw 'No token found, user is not logged in.';
      }

      // Membuat request PUT untuk mengupdate profil pengguna
      final response = await http.put(
        Uri.parse('$baseUrl/edit-profile'), // Endpoint untuk edit profile
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Mengirimkan token di header
        },
        body: jsonEncode(
            updatedUser.toJson()), // Mengirim data profil yang diupdate
      );

      if (response.statusCode == 200) {
        // Parsing response body untuk mendapatkan data profil terbaru
        final responseData = jsonDecode(response.body);
        UserModel updatedUserProfile = UserModel.fromJson(responseData['user']);

        // Simpan kembali data pengguna yang telah diperbarui ke local storage
        await storeCredentialToLocal(updatedUserProfile);

        // Kembalikan instance UserModel yang telah diperbarui
        return updatedUserProfile;
      } else {
        throw jsonDecode(response.body)['message'] ??
            'Failed to update profile';
      }
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
