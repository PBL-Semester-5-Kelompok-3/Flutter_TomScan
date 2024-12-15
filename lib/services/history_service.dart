import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toma_scan/models/history_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HistoryService {
  final String baseUrl;

  HistoryService({required this.baseUrl});

  Future<List<History>> getAllHistories() async {
    const storage = FlutterSecureStorage();
    String? id_user = await storage.read(key: 'id');
    String? token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/api/histories/user/$id_user'),
      headers: {
        'Authorization':
            'Bearer $token', // Include the token in the Authorization header
        'Content-Type': 'application/json', // Optional: Set the content type
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => History.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load histories: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
