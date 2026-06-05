class Student {
  final String id;
  final String name;
  final int collegeCode;
  final bool isLeader;

  Student({

    required this.name,
    required this.collegeCode,
    required this.isLeader, required this.id,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json["_id"] ?? "",
      name: json["name"] ?? "",
      collegeCode: json["collegeCode"] ?? 0,
        isLeader: json['isLeader'] ?? false
      
    );
  }
}