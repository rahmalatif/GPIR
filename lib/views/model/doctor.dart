enum SupervisorStatus { available, full, almostFull }

class Doctor {
  final String uid;
  final String apiId;
  final String name;
  final String track;
  final int currentProjects;
  final int maxProjects;
  final bool available;
  final SupervisorStatus status;
  final String image;
  final String email;

  const Doctor({
    required this.uid,
    required this.apiId,
    required this.name,
    required this.track,
    required this.currentProjects,
    required this.maxProjects,
    required this.available,
    required this.status,
    required this.image,
    required this.email,
  });

  factory Doctor.fromJson(Map<String, dynamic> json, String firebaseUid) {
    final int current = json['currentProjects'] ?? 0;
    final int max = json['maxProjects'] ?? 4;
    final bool isAvailable = json['available'] ?? true;

    SupervisorStatus calculatedStatus = SupervisorStatus.available;
    if (!isAvailable || current >= max) {
      calculatedStatus = SupervisorStatus.full;
    } else if (max - current == 1) {
      calculatedStatus = SupervisorStatus.almostFull;
    }

    return Doctor(
      uid: firebaseUid,
      apiId: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      track: json['track'] ?? '',
      currentProjects: current,
      maxProjects: max,
      available: isAvailable,
      status: calculatedStatus,
      image: json['image'] ?? '',
    );
  }
}