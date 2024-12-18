import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:toma_scan/models/informatifs_model.dart';
import 'package:toma_scan/shared/shared_values.dart';

class InformatifsService {
  Future<List<Informative>> getAllInformatifsData() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/informatifs'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Kirim token yang didapatkan
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      print('berhasil');
      return data.map((item) => Informative.fromJson(item)).toList();
    } else {
      print('gagal');
      throw Exception('Failed to load informatifs data');
    }
  }

  Future<List<PestAndDisease>> getAllPestAndDiseaseData() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    final response = await http.get(
      Uri.parse(
          '$baseUrl/pests-and-diseases'), // Replace with your actual endpoint
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Send the token
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((item) => PestAndDisease.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load pest and disease data');
    }
  }
}
