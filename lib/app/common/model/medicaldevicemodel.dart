class MedicalDeviceModel {
  final String pmaNumber;
  final String deviceName;
  final String decisionCode;
  final String decisionDate;
  final String applicant;
  final String summary;
  final String approvalOrder;
  final String dateReceived;
  final String advisoryCommitteeDescription;
  final String medicalSpecialtyDescription;

  MedicalDeviceModel({
    required this.pmaNumber,
    required this.deviceName,
    required this.decisionCode,
    required this.decisionDate,
    required this.applicant,
    required this.summary,
    required this.approvalOrder,
    required this.dateReceived,
    required this.advisoryCommitteeDescription,
    required this.medicalSpecialtyDescription,
  });

  factory MedicalDeviceModel.fromJson(Map<String, dynamic> json) {
    return MedicalDeviceModel(
      pmaNumber: json['pma_number'] ?? '',
      deviceName:
          json['openfda'] != null && json['openfda']['device_name'] != null
              ? json['openfda']['device_name']
              : 'Unknown Device',
      decisionCode: json['decision_code'] ?? '',
      decisionDate: json['decision_date'] ?? '',
      applicant: json['applicant'] ?? '',
      summary: json['summary'] ?? '',
      approvalOrder: json['approval_order'] ?? '',
      dateReceived: json['date_received'] ?? '',
      advisoryCommitteeDescription:
          json['advisory_committee_description'] ?? '',
      medicalSpecialtyDescription: json['medical_specialty_description'] ?? '',
    );
  }
}
