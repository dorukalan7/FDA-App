import 'package:fda/view/medicaldevice/service/medicaldeviceservice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'medical_device_state.dart';

enum SortOrder { ascending, descending }

class MedicalDeviceCubit extends Cubit<MedicalDeviceState> {
  final MedicalDeviceService service;
  List<dynamic> _devices = [];

  MedicalDeviceCubit({required this.service}) : super(MedicalDeviceInitial());

  Future<void> fetchDevicesByStatus(String status) async {
    emit(MedicalDeviceLoading());
    try {
      final devices = await service.fetchDevicesByStatus(status);
      _devices = devices;
      emit(MedicalDeviceLoaded(devices: _devices));
    } catch (e) {
      emit(MedicalDeviceError(message: e.toString()));
    }
  }

  void sortDevicesByDate(SortOrder order) {
    final sortedDevices = [..._devices];
    sortedDevices.sort((a, b) {
      final dateA = DateTime.tryParse(a.decisionDate) ?? DateTime(0);
      final dateB = DateTime.tryParse(b.decisionDate) ?? DateTime(0);

      return order == SortOrder.descending
          ? dateB.compareTo(dateA)
          : dateA.compareTo(dateB);
    });

    emit(MedicalDeviceLoaded(devices: sortedDevices));
  }
}
