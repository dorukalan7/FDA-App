// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fda/model/recall_model.dart';
import 'package:fda/view/foodspage/service/foodsservice.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  final RecallService service;

  StatusCubit(this.service) : super(StatusInitial());

  Future<void> fetchRecallsByStatus(String status) async {
    emit(StatusLoading());
    try {
      final recalls = await service.getRecallsByStatus(status);
      emit(StatusLoaded(recalls));
    } catch (e) {
      emit(StatusError("Veri alınamadı: $e"));
    }
  }

  Future<void> fetchRecallsByStatusSorted(
    String status, {
    required bool ascending,
  }) async {
    emit(StatusLoading());

    try {
      final recalls = await service.getRecallsByStatus(status);

      recalls.sort((a, b) {
        final dateA = parseDateString(a.recallDate);
        final dateB = parseDateString(b.recallDate);

        if (dateA == null || dateB == null) return 0;

        return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
      });

      emit(StatusLoaded(recalls));
    } catch (e) {
      emit(StatusError("Sıralama hatası: $e"));
    }
  }

  // Tarihi güvenli şekilde DateTime'a çevir
  DateTime? parseDateString(String? dateStr) {
    try {
      return DateTime.parse(dateStr!); // Örn: "2023-05-01"
    } catch (_) {
      return null;
    }
  }
}
