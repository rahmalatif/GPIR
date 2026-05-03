import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';

class RegisterMobileView extends StatefulWidget {
  final String role;

  const RegisterMobileView({super.key, required this.role});

  @override
  State<RegisterMobileView> createState() => _RegisterMobileViewState();
}

class _RegisterMobileViewState extends State<RegisterMobileView> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  void register() async {
    try {
      final user = await AuthService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        role: widget.role,
      );

      print("Welcome ${user.name}");

      context.go('/login');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isStudent = widget.role == "student";

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text(
                "Register as ${widget.role}",
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 30),
              _input("Name", false, nameController, keyboardType: TextInputType.name),
              const SizedBox(height: 20),
              _input(
                isStudent ? "Student ID" : "Email",
                false,
                emailController,
                keyboardType: isStudent
                    ? TextInputType.number
                    : TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              _input("Password", true, passwordController, keyboardType:TextInputType.visiblePassword),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF46F0D2),
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  register();
                },
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  context.go('/login', extra: widget.role);
                },
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _input(
    String label,
    bool isPassword,
    TextEditingController controller, {
      required TextInputType keyboardType,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType, // 🔥 هنا المهم
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF4699A8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.lightBlueAccent),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    ),
  );
}