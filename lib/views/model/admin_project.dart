class AdminProject {
  final String id;
  final String name;
  final String status;
  final String date;
  final List<String> team;
  final String description;

  AdminProject(
      {required this.name,
      required this.status,
      required this.date,
      required this.team,
      required this.description,
      required this.id,});
}
