enum SupervisorStatus { available, full, almostFull }

class Doctor {
  final String id;
  final String name;
  final String track;
  final int slots;
  final SupervisorStatus status;
  final String image;
  final String email;

  const Doctor({
    required this.id,
    required this.name,
    required this.track,
    required this.slots,
    required this.status,
    required this.image,
    required this.email,
  });
}
