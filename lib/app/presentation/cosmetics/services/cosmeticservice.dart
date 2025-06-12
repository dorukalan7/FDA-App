import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fda/model/tobaccomodel.dart';

class TobaccoService {
  Future<List<TobaccoReport>> fetchTobaccoReports(String status) async {
    final url = Uri.parse('https://api.fda.gov/tobacco/problem.json?limit=30');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];

      return results.map((json) => TobaccoReport.fromJson(json)).toList();
    } else {
      throw Exception('Veri alınamadı. Kod: ${response.statusCode}');
    }
  }
}
