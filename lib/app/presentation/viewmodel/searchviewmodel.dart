import 'package:fda/app/common/model/FavoriteModel.dart';
import 'package:fda/app/common/model/Listler.dart';
import 'package:fda/app/common/model/Drug_model.dart';
import 'package:fda/app/common/model/medicaldevicemodel.dart';
import 'package:fda/app/common/model/Food_model.dart';
import 'package:fda/app/common/model/tobaccomodel.dart';
import 'package:fda/app/common/model/vacmodel.dart';
import 'package:fda/app/presentation/drugspage/service/drugservice.dart';
import 'package:fda/app/presentation/foodspage/service/foodsservice.dart';
import 'package:fda/app/presentation/medicaldevice/service/medicaldeviceservice.dart';
import 'package:fda/app/presentation/tobaccopage/services/tobacco_service.dart';
import 'package:fda/app/presentation/vaccines/services/vacservices.dart';

class Searchviewmodel {
  Future<List<Vacmodel>> fetchVaccines() async {
    try {
      final vacService = VacService();
      return await vacService.fetchVacs(limit: 30);
    } catch (e) {
      print('Vac fetch error: $e');
      return [];
    }
  }

  Future<List<TobaccoReport>> fetchTobaccos() async {
    try {
      final tobaccoService = TobaccoService();
      return await tobaccoService.fetchTobaccoReports('');
    } catch (e) {
      print('Tobacco fetch error: $e');
      return [];
    }
  }

  Future<List<MedicalDeviceModel>> fetchDevices() async {
    try {
      final medicaldevice = MedicalDeviceService();
      return await medicaldevice.fetchDevicesByStatus('');
    } catch (e) {
      print('Device fetch error: $e');
      return [];
    }
  }

  Future<List<RecallModel>> fetchRecalls() async {
    try {
      final recallService = RecallService();

      return await recallService.getRecallsByStatus('');
    } catch (e) {
      print('Recall fetch error: $e');
      return [];
    }
  }

  Future<List<DrugInfo>> fetchDrugs() async {
    try {
      final drugService = DrugService();

      return await drugService.fetchDrugsByRoute('oral');
    } catch (e) {
      print('Drug fetch error: $e');
      return [];
    }
  }

  Future<List<FavoriteItem>> fetchAllFavorites() async {
    final vaccines = await fetchVaccines();
    final tobaccos = await fetchTobaccos();
    final devices = await fetchDevices();
    final recalls = await fetchRecalls();
    final drugs = await fetchDrugs();

    return combineAllFavorites(
      vaccines: vaccines,
      tobaccos: tobaccos,
      devices: devices,
      recalls: recalls,
      drugs: drugs,
    );
  }
}
