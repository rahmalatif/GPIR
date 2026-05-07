class ProjectIdea {

  final String title;

  final String description;

  final List<String> tools;

  final List<String> specialization;

  final String doctorId;

  final String taId;

  final int year;

  final TeamData team;

  ProjectIdea({

    required this.title,

    required this.description,

    required this.tools,

    required this.specialization,

    required this.doctorId,

    required this.taId,

    required this.year,

    required this.team,
  });

  Map<String, dynamic> toJson() {

    return {

      "title": title,

      "description": description,

      "tools": tools,

      "specialization": specialization,

      "doctor_id": doctorId,

      "ta_id": taId,

      "year": year,

      "team": team.toJson(),
    };
  }
}

class TeamData {

  final String leaderId;

  final List<TeamMemberData> members;

  TeamData({

    required this.leaderId,

    required this.members,
  });

  Map<String, dynamic> toJson() {

    return {

      "leader_id": leaderId,

      "members":
      members.map((e) => e.toJson()).toList(),
    };
  }
}
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