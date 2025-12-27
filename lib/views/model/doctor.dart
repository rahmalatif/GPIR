
enum SupervisorStatus { available, full, almostFull }
class Doctor{
  final String name;
  final String track;
  final int slots;
  final SupervisorStatus status;
  final String image;

  const Doctor({
    required this.name,
    required this.track,
    required this.slots,
    required this.status,
    required this.image,
  });
}