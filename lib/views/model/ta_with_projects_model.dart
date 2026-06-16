class TaWithProjectsModel {
  final String id;
  final String name;
  final String email;
  final int projectsCount;

  TaWithProjectsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.projectsCount,
  });

  factory TaWithProjectsModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return TaWithProjectsModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      projectsCount: json['projectsCount'],
    );
  }
}