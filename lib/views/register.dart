import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';
import '../core/logic/go_router.dart';
import '../core/design/app_image.dart';

class RegisterView extends StatefulWidget {
  final String role;

  const RegisterView({super.key, required this.role});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmController;

  bool isLoading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (passwordController.text != confirmController.text) {
      setState(() => error = "Passwords do not match");
      return;
    }

    if (passwordController.text.length < 6) {
      setState(() => error = "Password should be at least 6 characters");
      return;
    }

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() => error = "Please fill all fields");
      return;
    }

    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      await AuthService().register(
        emailController.text.trim(),
        passwordController.text.trim(),
        widget.role,
      );

      await FirebaseAuth.instance.signOut();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account created successfully! Please login."),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
      context.go('/login', extra: widget.role);

    } catch (e) {
      if (mounted) {
        setState(() {
          error = e.toString().replaceAll('Exception: ', '');
          isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60),
              AppImage(image: "assets/png/logo.png", height: 184, width: 184),
              const SizedBox(height: 20),
              Text(
                "Register as ${widget.role}",
                style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              _inputText("Email", false, emailController),
              const SizedBox(height: 20),

              _inputText("Password", true, passwordController),
              const SizedBox(height: 20),

              _inputText("Confirm Password", true, confirmController),
              const SizedBox(height: 40),

              if (error.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF46F0D2),
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: isLoading ? null : register,
                child: isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
                    : const Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputText(String label, bool isPassword, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFF4699A8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        ),
      ),
    );
  }
}