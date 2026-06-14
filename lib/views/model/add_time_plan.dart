class TimePlanModel {
  final String id;
  final String projectId;
  final String status;
  final List<TaskModel> tasks;

  TimePlanModel({
    required this.id,
    required this.projectId,
    required this.status,
    required this.tasks,
  });

  factory TimePlanModel.fromJson(Map<String, dynamic> json) {
    final plan = json['plan'] ?? {};

    return TimePlanModel(
      id: plan['_id'] ?? '',
      projectId: plan['project_id'] ?? '',
      status: plan['status'] ?? '',
      tasks: plan['tasks'] != null
          ? (plan['tasks'] as List).map((e) => TaskModel.fromJson(e)).toList()
          : [],
    );
  }
}
class TaskModel {
  final String title;
  final String description;
  final String deadline;

  TaskModel({
    required this.title,
    required this.description,
    required this.deadline,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      deadline: json['deadline'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "deadline": deadline,
    };
  }
}