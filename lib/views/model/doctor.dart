enum SupervisorStatus { available, full, almostFull }

class Doctor {
  final String uid;
  final String apiId;
  final String name;
  final String track;
  final int slots;
  final SupervisorStatus status;
  final String image;
  final String email;

  const Doctor({
    required this.uid,
    required this.apiId,
    required this.name,
    required this.track,
    required this.slots,
    required this.status,
    required this.image,
    required this.email,
  });

  factory Doctor.fromJson(Map<String, dynamic> json, String firebaseUid) {
    return Doctor(
      uid: firebaseUid,
      apiId: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      track: json['track'] ?? '',
      slots: json['slots'] ?? 0,
      status: _parseStatus(json['status']),
      image: json['image'] ?? '',
    );
  }




  static SupervisorStatus _parseStatus(dynamic value) {
    switch (value) {
      case 'available':
        return SupervisorStatus.available;
      case 'full':
        return SupervisorStatus.full;
      case 'almostFull':
        return SupervisorStatus.almostFull;
      default:
        return SupervisorStatus.available;
    }
  }
}
