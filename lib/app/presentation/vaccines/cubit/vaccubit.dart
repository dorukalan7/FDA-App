import 'package:fda/app/common/model/vacmodel.dart';
import 'package:fda/app/presentation/vaccines/services/vacservices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'vac_state.dart';

enum SortOrder { ascending, descending }

class VacCubit extends Cubit<VacState> {
  final VacService service;
  List<Vacmodel> _reports = [];

  VacCubit({required this.service}) : super(VacInitial());

  Future<void> fetchVacs(String status) async {
    emit(VacLoading());
    try {
      final reports = await service.fetchVacs();
      _reports = reports;
      emit(VacLoaded(reports: _reports));
    } catch (e) {
      emit(VacError(message: e.toString()));
    }
  }

  void sortReports(SortOrder order) {
    List<Vacmodel> sorted = [..._reports];

    sorted.sort((a, b) {
      final dateA = _parseDate(a.marketingStartDate);
      final dateB = _parseDate(b.marketingStartDate);
      return order == SortOrder.descending
          ? dateB.compareTo(dateA)
          : dateA.compareTo(dateB);
    });

    emit(VacLoaded(reports: sorted));
  }

  DateTime _parseDate(String dateStr) {
    try {
      final year = int.parse(dateStr.substring(0, 4));
      final month = int.parse(dateStr.substring(4, 6));
      final day = int.parse(dateStr.substring(6, 8));
      return DateTime(year, month, day);
    } catch (_) {
      return DateTime(1900);
    }
  }
}
