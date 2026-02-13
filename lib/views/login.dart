import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';
import '../core/logic/go_router.dart';
import '../core/design/app_image.dart';

class LoginView extends StatefulWidget {
  final String role;

  const LoginView({super.key, required this.role});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

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
              Text("Login as ${widget.role}",
                  style: const TextStyle(fontSize: 24, color: Colors.white)),
              const SizedBox(height: 30),
              _InputText("Email", false, emailController),
              const SizedBox(height: 20),
              _InputText("Password", true, passwordController),
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
                  try {
                    final user = await AuthService().login(emailController.text, passwordController.text);

                    if (user != null && mounted) {
                      print("USER LOGGED IN SUCCESS");

                      if (widget.role == 'admin') context.go('/AdminDashboard');
                      else if (widget.role == 'doctor') context.go('/doctorDashboard');
                      else if (widget.role == 'library') context.go('/libraryDashboard');
                      else if (widget.role == 'student') context.go('/studentDashboard');
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
                      );
                    }
                  }
                },
                child: const Text("Login" , style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 10,),
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
    TextEditingController controller,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: TextField(
      controller: controller,
      obscureText: isPassword,
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