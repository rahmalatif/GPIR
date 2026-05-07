class SimilarProject {

  final String title;
  final String doctor;
  final int year;
  final double similarity;

  SimilarProject({
    required this.title,
    required this.doctor,
    required this.year,
    required this.similarity,
  });

  factory SimilarProject.fromJson(
      Map<String, dynamic> json) {

    return SimilarProject(
      title: json['title'],
      doctor: json['doctor'],
      year: json['year'],
      similarity:
      (json['similarity'] as num)
          .toDouble(),
    );
  }
}

class SimilarityResponse {

  final double similarity;

  final String status;

  final List<SimilarProject> projects;

  SimilarityResponse({
    required this.similarity,
    required this.status,
    required this.projects,
  });

  factory SimilarityResponse.fromJson(
      Map<String, dynamic> json) {

    return SimilarityResponse(

      similarity:
      (json['similarity'] as num)
          .toDouble(),

      status: json['status'],

      projects: (json['projects'] as List)

          .map((e) =>
          SimilarProject.fromJson(e))

          .toList(),
    );
  }
}