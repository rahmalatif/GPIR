class Student {
  final String name;
  final int collegeCode;
  final bool isLeader;

  Student({

    required this.name,
    required this.collegeCode,
    required this.isLeader,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json["name"] ?? "",
      collegeCode: json["collegeCode"] ?? 0,
        isLeader: json['isLeader'] ?? false
      
    );
  }
}