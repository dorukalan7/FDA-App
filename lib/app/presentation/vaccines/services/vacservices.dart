import 'package:dio/dio.dart';
import 'package:fda/model/vacmodel.dart';

class VacService {
  final Dio _dio = Dio();

  Future<List<Vacmodel>> fetchVacs({int limit = 10}) async {
    final url = 'https://api.fda.gov/drug/ndc.json?limit=$limit';
    try {
      final response = await _dio.get(url);
      final results = response.data['results'] as List<dynamic>;
      return results.map((e) => Vacmodel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load vacs: $e');
    }
  }
}
