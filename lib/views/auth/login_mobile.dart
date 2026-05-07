import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/design/app_image.dart';
import '../../services/auth_service.dart';
import '../model/user_model.dart';

class LoginMobileView extends StatefulWidget {
  final String role;

  const LoginMobileView({super.key, required this.role});

  @override
  State<LoginMobileView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginMobileView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void navigateBasedOnRole(BuildContext context, UserModel user) {
    switch (user.role) {
      case 'student':
        context.go('/studentDashboard', extra: user);
        break;

      case 'doctor':
        context.go('/doctorDashboard', extra: user);
        break;

      case 'admin':
        context.go('/adminDashboard', extra: user);
        break;

      case 'library':
        context.go('/libraryDashboard', extra: user);
        break;

      case 'teacher assistant':
        context.go('/taDashboard', extra: user);
        break;

      default:
        context.go('/login');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isStudent = widget.role == "student";
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body:  SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60),

              AppImage(
                image: "assets/png/logo.png",
                height: 184,
                width: 184,
              ),

              const SizedBox(height: 20),

              Text(
                "Login as ${widget.role}",
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              _InputText(
                isStudent ? "Student ID" : "Email",
                false,
                emailController,
                keyboardType: isStudent
                    ? TextInputType.number
                    : TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              _InputText(
                "Password",
                true,
                passwordController,
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height: 60),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF46F0D2),
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  final input = emailController.text.trim();
                  final password = passwordController.text.trim();

                  if (input.isEmpty || password.isEmpty) {
                    showError("Please fill all fields");
                    return;
                  }

                  if (!isStudent && !input.contains("@")) {
                    showError("Please enter a valid email");
                    return;
                  }

                  final parsedId =
                  isStudent ? int.tryParse(input) : null;

                  if (isStudent && parsedId == null) {
                    showError("ID must be a number");
                    return;
                  }

                  setState(() {
                    isLoading = true;
                  });

                  try {
                    final result = await AuthService.login(
                      role: widget.role,
                      password: password,
                      email: isStudent ? null : input,
                      id: parsedId,
                    );

                    if (widget.role == "student") {
                      context.go(
                        '/studentDashboard',
                        extra: result,
                      );
                    } else {
                      final user = result as UserModel;
                      navigateBasedOnRole(context, user);
                    }
                  } catch (e) {
                    showError(
                      e.toString().replaceAll("Exception: ", ""),
                    );
                  }

                  print(AuthService.token);

                  if (!mounted) return;

                  setState(() {
                    isLoading = false;
                  });
                },
                child: isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  context.go(
                    '/register',
                    extra: widget.role,
                  );
                },
                child: const Text(
                  "Don't have an account? Register",
                  style: TextStyle(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _InputText(
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
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white70),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color(0xFF4699A8),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.lightBlueAccent,
          ),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    ),
  );
}