import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toma_scan/models/informatif_model.dart';

class InformatifsService {
  Future<List<InformatifsModel>> getAllInformatifsData() async {
    final response = await http.get(Uri.parse('/api/informatifs'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((item) => InformatifsModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load informatifs data');
    }
  }

  Future<InformatifsModel> getInformatifsData(int id) async {
    final response = await http.get(Uri.parse('/api/informatifs/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return InformatifsModel.fromJson(data);
    } else {
      throw Exception('Failed to load informatis data');
    }
  }

  Future<void> createInformatifsData(InformatifsModel informatifsData) async {
    final response = await http.post(
      Uri.parse('/api/informatifs'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(informatifsData.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create informatis data');
    }
  }

  Future<void> updateInformatifsData(
      int id, InformatifsModel informatifsData) async {
    final response = await http.put(
      Uri.parse('/api/informatifs/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(informatifsData.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update informatis data');
    }
  }

  Future<void> deleteInformatifsData(int id) async {
    final response = await http.delete(Uri.parse('/api/informatifs/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete informatis data');
    }
  }
}
