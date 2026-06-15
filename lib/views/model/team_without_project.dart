class TeamWithoutProjectModel {
  final String id;
  final String teamName;
  final Leader leader;
  final List<Member> members;

  TeamWithoutProjectModel({
    required this.id,
    required this.teamName,
    required this.leader,
    required this.members,
  });

  factory TeamWithoutProjectModel.fromJson(Map<String, dynamic> json) {
    return TeamWithoutProjectModel(
      id: json['_id'] ?? '',
      teamName: json['team_name'] ?? '',
      leader: Leader.fromJson(json['leader_id']),
      members:
          (json['members'] as List).map((e) => Member.fromJson(e)).toList(),
    );
  }
}

class Leader {
  final String id;
  final String name;
  final String phone;

  Leader({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory Leader.fromJson(Map<String, dynamic> json) {
    return Leader(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}

class Member {
  final String id;
  final String name;
  final String phone;

  Member({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}
