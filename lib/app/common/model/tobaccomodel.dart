class TobaccoReport {
  final String dateSubmitted;
  final String nonuserAffected;
  final List<String> reportedHealthProblems;
  final int numberTobaccoProducts;
  final int reportId;
  final int numberHealthProblems;
  final List<String> reportedProductProblems;
  final List<String> tobaccoProducts;
  final int numberProductProblems;

  TobaccoReport({
    required this.dateSubmitted,
    required this.nonuserAffected,
    required this.reportedHealthProblems,
    required this.numberTobaccoProducts,
    required this.reportId,
    required this.numberHealthProblems,
    required this.reportedProductProblems,
    required this.tobaccoProducts,
    required this.numberProductProblems,
  });

  factory TobaccoReport.fromJson(Map<String, dynamic> json) {
    return TobaccoReport(
      dateSubmitted: json['date_submitted'] ?? '',
      nonuserAffected: json['nonuser_affected'] ?? '',
      reportedHealthProblems: List<String>.from(
        json['reported_health_problems'] ?? [],
      ),
      numberTobaccoProducts: json['number_tobacco_products'] ?? 0,
      reportId: json['report_id'] ?? 0,
      numberHealthProblems: json['number_health_problems'] ?? 0,
      reportedProductProblems: List<String>.from(
        json['reported_product_problems'] ?? [],
      ),
      tobaccoProducts: List<String>.from(json['tobacco_products'] ?? []),
      numberProductProblems: json['number_product_problems'] ?? 0,
    );
  }
}
