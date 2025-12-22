import 'package:flutter/material.dart';
import '../../core/design/app_image.dart';

enum SupervisorStatus { available, full, almostFull }

class ChooseSupervisorView extends StatelessWidget {
  const ChooseSupervisorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor:  Color(0xFF0D0F1A),
        elevation: 0,
        leading:  BackButton(color: Colors.white),
        title:  Text(
          "Choose Supervisor",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 8.0),
            child: Column(children: [
               Text(
                "Select the supervisor for your Idea",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
               SizedBox(height: 16),
            ]),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 350,
            height: 45,
            padding:  EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child:  Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  "Search supervisor by name",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children:  [
                DoctorContainer(
                  name: "Dr. Ahmed Ibrahim",
                  track: "Backend",
                  slots: 5,
                  status: SupervisorStatus.available,
                  profileImage: 'assets/png/man.png',
                ),
                DoctorContainer(
                  name: "Dr. Lamiaa",
                  track: "Backend",
                  slots: 0,
                  status: SupervisorStatus.full,
                  profileImage: 'assets/png/women.png',
                ),
                DoctorContainer(
                  name: "Dr. Abdelfattah",
                  track: "AI & ML",
                  slots: 1,
                  status: SupervisorStatus.almostFull,
                  profileImage: 'assets/png/man.png',
                ),
              ],
            ),
          ),
          ElevatedButton(

            onPressed: () {},
            style: ElevatedButton.styleFrom(
              maximumSize: Size(300, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child:  Text(
              "Select",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
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

  const DoctorContainer({
    super.key,
    required this.name,
    required this.track,
    required this.slots,
    required this.status,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
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
                    fontWeight: FontWeight.w700
                  ),

                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    track,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      "Available slots:",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      " $slots",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),

                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _statusColor(status),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: Text(
              _status(status),
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
          )
        ],
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
