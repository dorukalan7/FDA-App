import 'package:fda/model/tobaccomodel.dart';
import 'package:fda/view/tobaccopage/utils/datetime.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fda/view/tobaccopage/services/tobacco_service.dart';
import 'package:fda/view/tobaccopage/cubit/cubitstate.dart';

enum SortOrder { ascending, descending }

class TobaccoCubit extends Cubit<TobaccoState> {
  final TobaccoService service;
  List<TobaccoReport> _reports = [];

  TobaccoCubit({required this.service}) : super(TobaccoInitial());

  Future<void> fetchReports(String status) async {
    emit(TobaccoLoading());
    try {
      final reports = await service.fetchTobaccoReports(status);
      _reports = reports;
      emit(TobaccoLoaded(reports: _reports));
    } catch (e) {
      emit(TobaccoError(message: e.toString()));
    }
  }

  void sortReports(SortOrder order) {
    print("Sıralama yapılıyor: $order");

    final sortedReports = [..._reports];
    sortedReports.sort((a, b) {
      final dateA = parseCustomDate(a.dateSubmitted);
      final dateB = parseCustomDate(b.dateSubmitted);
      return order == SortOrder.descending
          ? dateB.compareTo(dateA)
          : dateA.compareTo(dateB);
    });

    emit(TobaccoLoaded(reports: sortedReports));
  }
}
