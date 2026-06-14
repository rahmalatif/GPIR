class InvitationModel {
  final String id;
  final String name;
  final String specialization;
  final String phone;
  final int collegeCode;
  final String status;

  InvitationModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.phone,
    required this.collegeCode,
    required this.status,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['_id'] ?? '',
      name: json['sender_id']['name'] ?? '',
      specialization:
      json['sender_id']['specialization'] ?? '',
      phone: json['sender_id']['phone'] ?? '',
      collegeCode:
      json['sender_id']['collegeCode'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}