class LibraryProject {
  final String id;
  final String name;
  final String description;
  final String year;
  final String doctor;
  final String teachingAssistant;
  final String pdfUrl;
  final List<String> team;

  LibraryProject({
    required this.id,
    required this.name,
    required this.description,
    required this.year,
    required this.doctor,
    required this.teachingAssistant,
    required this.team,
    this.pdfUrl = '',
  });
}
