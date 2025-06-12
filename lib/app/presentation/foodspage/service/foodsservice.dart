import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/recall_model.dart';

class RecallService {
  Future<List<RecallModel>> getRecallsByStatus(String status) async {
    final url = Uri.parse(
      'https://api.fda.gov/food/enforcement.json?search=status:"$status"&limit=30',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final results = jsonBody['results'] as List;

      return results.map((e) => RecallModel.fromJson(e)).toList();
    } else {
      throw Exception("API çağrısı başarısız: ${response.statusCode}");
    }
  }
}
