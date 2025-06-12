import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/drugsinfo.dart';

class DrugService {
  Future<List<DrugInfo>> fetchDrugsByRoute(String route) async {
    final url = Uri.parse(
      'https://api.fda.gov/drug/drugsfda.json?search=openfda.route:$route&limit=10',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((item) => DrugInfo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load drugs');
    }
  }
}
