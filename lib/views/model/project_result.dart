class ProjectResult {
  final double similarity;

  ProjectResult({required this.similarity});

  factory ProjectResult.fromJson(Map<String, dynamic> json) {
    return ProjectResult(
      similarity: (json['similarity'] ?? 0).toDouble(),
    );
  }
}