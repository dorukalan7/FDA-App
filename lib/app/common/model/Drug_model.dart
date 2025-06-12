import 'package:fda/utils/dateformat.dart';

class DrugInfo {
  final String brandName;
  final String genericName;
  final String sponsorName;
  final String manufacturerName;
  final String applicationNumber;
  final String submissiondate;
  final String dosageForm;
  final String route;

  DrugInfo({
    required this.brandName,
    required this.genericName,
    required this.sponsorName,
    required this.manufacturerName,
    required this.applicationNumber,
    required this.submissiondate,
    required this.dosageForm,
    required this.route,
  });

  factory DrugInfo.fromJson(Map<String, dynamic> item) {
    final openfda = item['openfda'] ?? {};
    final products = item['products'] ?? [];
    final product = products.isNotEmpty ? products[0] : {};

    return DrugInfo(
      brandName:
          openfda['brand_name']?[0] ?? product['brand_name'] ?? 'Unknown',
      genericName:
          openfda['generic_name']?[0] ?? product['generic_name'] ?? 'Unknown',
      sponsorName: item['sponsor_name'] ?? 'Unknown',
      manufacturerName: product['manufacturer_name'] ?? 'Unknown',
      applicationNumber: item['application_number'] ?? 'Unknown',
      submissiondate:
          item['submissions'] != null && item['submissions'].isNotEmpty
              ? formatDate(
                item['submissions'][0]['submission_status_date'] ?? 'N/A',
              )
              : 'N/A',

      dosageForm:
          openfda['dosage_form']?[0] ?? product['dosage_form'] ?? 'Unknown',
      route: openfda['route']?[0] ?? product['route'] ?? 'Unknown',
    );
  }
}
