class DoctorWithProjectsModel {
  final String id;
  final String name;
  final String email;
  final int projectsCount;

  DoctorWithProjectsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.projectsCount,
  });

  factory DoctorWithProjectsModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return DoctorWithProjectsModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      projectsCount: json['projectsCount'],
    );
  }
}