import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/model/doctor.dart';
import 'package:graduation_project_recommender/views/model/project_idea.dart';

import '../../../core/design/app_image.dart';
import '../../../services/doctor_service.dart';

class ChooseSupervisorMobileView extends StatefulWidget {
  final ProjectIdea projectIdea;

  const ChooseSupervisorMobileView({
    super.key,
    required this.projectIdea,
    required doctor,
  });

  @override
  State<ChooseSupervisorMobileView> createState() =>
      _ChooseSupervisorMobileViewState();
}

class _ChooseSupervisorMobileViewState
    extends State<ChooseSupervisorMobileView> {
  int? selectedIndex;

  List<dynamic> doctors = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadDoctors();
  }

  Future<void> loadDoctors() async {
    doctors = await DoctorService.getDoctors();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        title: const Text(
          "Choose Supervisor",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            "Select the supervisor for your Idea",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];

                      return DoctorContainer(
                        doctor: doctor,
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
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                if (selectedIndex == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please select a supervisor",
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );

                  return;
                }

                context.go(
                  '/chooseTA',
                  extra: {
                    'projectIdea': widget.projectIdea,
                    'doctor': doctors[selectedIndex!],
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D0F1A),
                side: const BorderSide(
                  color: Color(0xff4699A8),
                  width: 2,
                ),
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
  final dynamic doctor;
  final bool isSelected;
  final VoidCallback onTap;

  const DoctorContainer({
    super.key,
    required this.doctor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xff4699A8).withOpacity(0.15)
              : Colors.transparent,
          border: Border.all(
            color: isSelected ? const Color(0xff4699A8) : Colors.white24,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.transparent,
              child: AppImage(
                image: "assets/png/man.png",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor['name'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor['specialization'] ?? 'No Specialization',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 8),
                  /*      Row(
                    children: [
                      const Text(

               //   doctor['available_slots'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        " ${doctor.slots}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Available",
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
