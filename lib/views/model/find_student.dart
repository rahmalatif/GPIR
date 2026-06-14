class FindStudentModel {
  final String id;
  final String name;
  final int collegeCode;
  final String phone;
  final String specialization;

  FindStudentModel({
    required this.id,
    required this.name,
    required this.collegeCode,
    required this.phone,
    required this.specialization,
  });

  factory FindStudentModel.fromJson(Map<String, dynamic> json) {
    return FindStudentModel(
      id: json['_id'],
      name: json['name'],
      collegeCode: json['collegeCode'],
      phone: json['phone'],
      specialization: json['specialization'] ?? 'Not Specified',    );
  }
}