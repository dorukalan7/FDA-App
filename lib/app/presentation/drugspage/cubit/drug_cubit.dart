import 'package:bloc/bloc.dart';
import 'package:fda/model/drugsinfo.dart';
import 'package:fda/view/drugspage/service/drugservice.dart';
import 'package:meta/meta.dart';

part 'drug_state.dart';

class DrugCubit extends Cubit<DrugState> {
  final DrugService drugService;

  DrugCubit({required this.drugService}) : super(DrugInitial());

  void fetchDrugsByRoute(String route) async {
    emit(DrugLoading());
    try {
      final drugs = await drugService.fetchDrugsByRoute(route);
      emit(DrugLoaded(drugs));
    } catch (e) {
      emit(DrugError(e.toString()));
    }
  }
}
