class CosmeticReport {
  final String dateSubmitted;
  final String reportId;
  final List<String> ingredients;
  final List<String> adverseEvents;
  final List<String> productTypes;

  CosmeticReport({
    required this.dateSubmitted,
    required this.reportId,
    required this.ingredients,
    required this.adverseEvents,
    required this.productTypes,
  });

  factory CosmeticReport.fromJson(Map<String, dynamic> json) {
    return CosmeticReport(
      dateSubmitted: json['date_received'] ?? '',
      reportId: json['report_number'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      adverseEvents: List<String>.from(json['adverse_event'] ?? []),
      productTypes: List<String>.from(json['product_types'] ?? []),
    );
  }
}
