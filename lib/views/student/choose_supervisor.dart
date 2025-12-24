import 'package:flutter/material.dart';
import '../../core/design/app_image.dart';

enum SupervisorStatus { available, full, almostFull }

class ChooseSupervisorView extends StatefulWidget {
  const ChooseSupervisorView({super.key});

  @override
  State<ChooseSupervisorView> createState() => _ChooseSupervisorViewState();
}

class _ChooseSupervisorViewState extends State<ChooseSupervisorView> {
  int? selectedIndex;

  final List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. Ahmed Ibrahim",
      "track": "Backend",
      "slots": 5,
      "status": SupervisorStatus.available,
      "image": "assets/png/man.png",
    },
    {
      "name": "Dr. Lamiaa",
      "track": "Backend",
      "slots": 0,
      "status": SupervisorStatus.full,
      "image": "assets/png/women.png",
    },
    {
      "name": "Dr. Abdelfattah",
      "track": "AI & ML",
      "slots": 1,
      "status": SupervisorStatus.almostFull,
      "image": "assets/png/man.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Choose Supervisor",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            "Select the supervisor for your Idea",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 20),

          // LIST
          Expanded(
            child: ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return DoctorContainer(
                  name: doctor["name"],
                  track: doctor["track"],
                  slots: doctor["slots"],
                  status: doctor["status"],
                  profileImage: doctor["image"],
                  isSelected: selectedIndex == index,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),

          // SELECT BUTTON
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                if (selectedIndex == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a supervisor"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                final selectedDoctor = doctors[selectedIndex!];

                Navigator.pushNamed(
                  context,
                  '/nextScreen',
                  arguments: selectedDoctor,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D0F1A),
                side: const BorderSide(color: Color(0xff4699A8), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Select",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}


class DoctorContainer extends StatelessWidget {
  final String name;
  final String track;
  final int slots;
  final SupervisorStatus status;
  final String profileImage;
  final bool isSelected;
  final VoidCallback onTap;

  const DoctorContainer({
    super.key,
    required this.name,
    required this.track,
    required this.slots,
    required this.status,
    required this.profileImage,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:  Color(0xff4699A8).withOpacity(0.15),
          border: Border.all(
            color: isSelected ? const Color(0xff4699A8) : Colors.white24,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.transparent,
              child: AppImage(image: profileImage),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    track,
                    style:
                    const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        "Available slots:",
                        style:
                        TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        " $slots",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _statusColor(status).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _status(status),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: _statusColor(status),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  static String _status(SupervisorStatus status) {
    switch (status) {
      case SupervisorStatus.available:
        return "Available";
      case SupervisorStatus.almostFull:
        return "Almost Full";
      case SupervisorStatus.full:
        return "Full";
    }
  }

  static Color _statusColor(SupervisorStatus status) {
    switch (status) {
      case SupervisorStatus.available:
        return Colors.green;
      case SupervisorStatus.almostFull:
        return Colors.orange;
      case SupervisorStatus.full:
        return Colors.red;
    }
  }

}
