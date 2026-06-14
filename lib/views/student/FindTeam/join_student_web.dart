import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../model/join_student_model.dart';

class JoinStudentWebView extends StatefulWidget {
  const JoinStudentWebView({super.key});

  @override
  State<JoinStudentWebView> createState() => _JoinStudentWebViewState();
}

class _JoinStudentWebViewState extends State<JoinStudentWebView> {
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
            icon: const Icon(
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 550),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1520),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF142232),
                    child: Icon(
                      Icons.person,
                      color: Colors.tealAccent,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Looking For A Team?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Your profile will appear in the available students section so team leaders can find and contact you.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                      style: const TextStyle(color: Colors.white, fontSize: 15),
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
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : joinAsStudent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.black,
                        ),
                      )
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
          ),
        ),
      ),
    );
  }
}