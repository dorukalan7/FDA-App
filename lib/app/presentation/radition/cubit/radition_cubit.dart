import 'package:fda/view/radition/cubit/radition_state.dart';
import 'package:fda/view/radition/services/raditionservice.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

enum SortOrder { ascending, descending }

class RadiationCubit extends Cubit<RadiationState> {
  final Radiationservice service;
  List<dynamic> _radiations = [];

  RadiationCubit({required this.service}) : super(RadiationInitial());

  Future<void> fetchRadiationDevices(String status) async {
    emit(RadiationLoading());
    try {
      final devices = await service.fetchRadiationDevices(status);
      _radiations = devices;
      emit(RadiationLoaded(devices: _radiations));
    } catch (e) {
      emit(RadiationError(message: e.toString()));
    }
  }

  void sortRadiationByDate(SortOrder order) {
    final sorted = [..._radiations];
    sorted.sort((a, b) {
      final dateA = DateTime.tryParse(a.decisionDate) ?? DateTime(0);
      final dateB = DateTime.tryParse(b.decisionDate) ?? DateTime(0);
      return order == SortOrder.descending
          ? dateB.compareTo(dateA)
          : dateA.compareTo(dateB);
    });

    emit(RadiationLoaded(devices: sorted));
  }
}
