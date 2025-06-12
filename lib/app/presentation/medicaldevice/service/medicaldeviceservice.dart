import 'package:dio/dio.dart';
import 'package:fda/app/common/model/medicaldevicemodel.dart';

class MedicalDeviceService {
  final Dio _dio = Dio();

  Future<List<MedicalDeviceModel>> fetchDevicesByStatus(String status) async {
    final String url =
        'https://api.fda.gov/device/pma.json?search=decision_code:$status&limit=20';

    try {
      final response = await _dio.get(url);
      final List<dynamic> dataList = response.data['results'];

      return dataList.map((json) => MedicalDeviceModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load medical devices: $e');
    }
  }
}
