class Vacmodel {
  final String proprietaryName;
  final String? applicationNumberOrCitation;
  final String productType;
  final String marketingStartDate; // "20120724" gibi yyyymmdd formatında
  final String? marketingEndDate; // nullable
  final String? inactivationDate; // nullable
  final String marketingCategory;
  final String packageNdcFirst4;
  final String dosageForm;

  Vacmodel({
    required this.proprietaryName,
    this.applicationNumberOrCitation,
    required this.productType,
    required this.marketingStartDate,
    this.marketingEndDate,
    this.inactivationDate,
    required this.marketingCategory,
    required this.packageNdcFirst4,
    required this.dosageForm,
  });

  factory Vacmodel.fromJson(Map<String, dynamic> json) {
    String getFirst4FromPackageNdc(String ndc) {
      String cleaned = ndc.replaceAll('-', '');
      return cleaned.length >= 4 ? cleaned.substring(0, 4) : cleaned;
    }

    String packageNdcFirst4 = 'N/A';
    if (json['packaging'] != null &&
        json['packaging'] is List &&
        json['packaging'].isNotEmpty) {
      packageNdcFirst4 = getFirst4FromPackageNdc(
        json['packaging'][0]['package_ndc'] ?? '',
      );
    }

    return Vacmodel(
      proprietaryName: json['brand_name'] ?? 'N/A',
      applicationNumberOrCitation:
          json['application_number'] ?? json['application_number_or_citation'],
      productType: json['product_type'] ?? 'N/A',
      marketingStartDate: json['marketing_start_date'] ?? 'N/A',
      marketingEndDate: json['marketing_end_date'],
      inactivationDate: json['inactivation_date'],
      marketingCategory: json['marketing_category'] ?? 'N/A',
      packageNdcFirst4: packageNdcFirst4,
      dosageForm: json['dosage_form'] ?? 'N/A',
    );
  }
}
