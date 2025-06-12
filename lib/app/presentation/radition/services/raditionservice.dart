import 'package:dio/dio.dart';

class Radiationservice {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchRadiationDevices(String status) async {
    final String url =
        'https://api.fda.gov/device/pma.json?search=decision_code:$status&limit=20';

    try {
      final response = await _dio.get(url);
      return response.data['results'];
    } catch (e) {
      throw Exception('Failed to load medical devices: $e');
    }
  }
}
