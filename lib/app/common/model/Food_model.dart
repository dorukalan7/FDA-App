class RecallModel {
  final String productDescription;
  final String city;
  final String state;
  final String status;
  final String? recallDate; // "recall_initiation_date"
  final String? terminationDate; // "termination_date"

  RecallModel({
    required this.productDescription,
    required this.city,
    required this.state,
    required this.status,
    this.recallDate,
    this.terminationDate,
  });

  factory RecallModel.fromJson(Map<String, dynamic> json) {
    return RecallModel(
      productDescription: json['product_description'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      status: json['status'] ?? '',
      recallDate: json['recall_initiation_date'],
      terminationDate: json['termination_date'],
    );
  }
}

DateTime? parseDateString(String? yyyymmdd) {
  if (yyyymmdd == null || yyyymmdd.length != 8) return null;

  final year = int.tryParse(yyyymmdd.substring(0, 4));
  final month = int.tryParse(yyyymmdd.substring(4, 6));
  final day = int.tryParse(yyyymmdd.substring(6, 8));

  if (year == null || month == null || day == null) return null;

  return DateTime(year, month, day);
}
