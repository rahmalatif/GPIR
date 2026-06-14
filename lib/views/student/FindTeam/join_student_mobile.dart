import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/join_student_model.dart';

class JoinStudentView extends StatefulWidget {
  const JoinStudentView({super.key});

  @override
  State<JoinStudentView> createState() => _JoinStudentViewState();
}

class _JoinStudentViewState extends State<JoinStudentView> {
  String? selectedSpecialization;

  final List<String> specializations = [
    'Mobile',
    'Backend',
    'Frontend',
    'AI',
    'Cyber Security',
  ];
  bool isLoading = false;

  Future<void> joinAsStudent() async {
    if (selectedSpecialization == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your specialization'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await JoinStudentService.joinAsStudent(
        specialization: selectedSpecialization!,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You are now available for teams'),
        ),
      );

      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          if (mounted) {
            context.go('/findTeam');
          }
        },
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go('/findTeam');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: const Color(0xFF0D0F1A),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Join as Student",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFF142232),
              child: Icon(
                Icons.person,
                color: Colors.tealAccent,
                size: 45,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Looking For A Team?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Your profile will appear in the available students section so team leaders can find and contact you.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF142232),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: selectedSpecialization,
                isExpanded: true,
                dropdownColor: const Color(0xFF142232),
                hint: const Text(
                  'Select Your Specialization',
                  style: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                underline: const SizedBox(),
                items: specializations.map((specialization) {
                  return DropdownMenuItem(
                    value: specialization,
                    child: Text(specialization),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSpecialization = value;
                  });
                },
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : joinAsStudent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  foregroundColor: Colors.black,
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Join Now",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
