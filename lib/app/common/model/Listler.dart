import 'package:fda/app/common/model/FavoriteModel.dart';
import 'package:fda/app/common/model/Drug_model.dart';
import 'package:fda/app/common/model/medicaldevicemodel.dart';
import 'package:fda/app/common/model/Food_model.dart';
import 'package:fda/app/common/model/tobaccomodel.dart';
import 'package:fda/app/common/model/vacmodel.dart';
// Diğer modeller

List<FavoriteItem> getFavoriteItemsFromVaccines(List<Vacmodel> reports) {
  return reports
      .map(
        (report) => FavoriteItem(
          id: report.packageNdcFirst4,
          title: report.proprietaryName,
          category: "Vaccines",
          data: report,
        ),
      )
      .toList();
}

List<FavoriteItem> getFavoriteItemsFromTobacco(List<TobaccoReport> reports) {
  return reports
      .map(
        (report) => FavoriteItem(
          id: report.reportId.toString(),
          title:
              report.tobaccoProducts.isNotEmpty
                  ? report.tobaccoProducts.first
                  : 'Unknown Product',
          category: 'TobaccoProducts',
          data: report,
        ),
      )
      .toList();
}

List<FavoriteItem> getFavoriteItemsFromDevices(
  List<MedicalDeviceModel> devices,
) {
  return devices
      .map(
        (device) => FavoriteItem(
          id: device.pmaNumber,
          title: device.deviceName,
          category: "Medical Devices",
          data: device,
        ),
      )
      .toList();
}

List<FavoriteItem> getFavoriteItemsFromFoodRecalls(List<RecallModel> recalls) {
  return recalls
      .map(
        (report) => FavoriteItem(
          id:
              '${report.productDescription}-${report.city}-${report.recallDate ?? 'unknown'}',
          title: report.productDescription,
          category: "Foods",
          data: report,
        ),
      )
      .toList();
}

List<FavoriteItem> getFavoriteItemsFromDrugs(List<DrugInfo> drugs) {
  return drugs
      .map(
        (drug) => FavoriteItem(
          id: drug.applicationNumber,
          title: drug.brandName,
          category: "Drugs",
          data: drug,
        ),
      )
      .toList();
}

List<FavoriteItem> combineAllFavorites({
  required List<Vacmodel> vaccines,
  required List<TobaccoReport> tobaccos,
  required List<MedicalDeviceModel> devices,
  required List<RecallModel> recalls,
  required List<DrugInfo> drugs,
  // Diğer kategoriler de eklenebilir
}) {
  final List<FavoriteItem> combined = [];

  combined.addAll(getFavoriteItemsFromVaccines(vaccines));
  combined.addAll(getFavoriteItemsFromTobacco(tobaccos));
  combined.addAll(getFavoriteItemsFromDevices(devices));
  combined.addAll(getFavoriteItemsFromFoodRecalls(recalls));
  combined.addAll(getFavoriteItemsFromDrugs(drugs));

  return combined;
}
