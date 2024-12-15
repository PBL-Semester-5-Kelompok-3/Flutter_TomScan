// scan_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toma_scan/models/scan_model.dart';

class ScanService {
  final String baseUrl;

  ScanService({required this.baseUrl});

  Future<void> saveHistory({
    required int userId,
    required int diseaseId,
    required String label,
    required String imagePath,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/history'),
      body: {
        'user_id': userId.toString(),
        'disease_id': diseaseId.toString(),
        'label': label,
        'image_path': imagePath,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save history');
    }
  }

  Future<ScanModel> fetchScanDetails(String disease) async {
    final response = await http.get(Uri.parse('$baseUrl/disease/$disease'));

    if (response.statusCode == 200) {
      return ScanModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load scan details');
    }
  }
}
