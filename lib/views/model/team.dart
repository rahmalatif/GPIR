class TeamMemberData {

  final String id;

  final int collegeCode;

  final String specialization;

  TeamMemberData({

    required this.id,

    required this.collegeCode,

    required this.specialization,
  });

  Map<String, dynamic> toJson() {

    return {

      "id": id,

      "collegeCode": collegeCode,

      "specialization": specialization,
    };
  }
}