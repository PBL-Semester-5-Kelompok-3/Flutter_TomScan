import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toma_scan/models/history_model.dart';

class HistoryService {
  final String baseUrl;

  HistoryService({required this.baseUrl});

  Future<List<History>> getAllHistories() async {
    final response = await http.get(Uri.parse('$baseUrl/api/histories'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((historyJson) => History.fromJson(historyJson)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized access. Please check your credentials.');
    } else if (response.statusCode == 500) {
      throw Exception('Internal server error. Please try again later.');
    } else {
      throw Exception(
          'Failed to load histories. Error: ${response.statusCode}');
    }
  }
}
