import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/auth_service.dart';

class RegisterMobileView extends StatefulWidget {
  final String role;

  const RegisterMobileView({
    super.key,
    required this.role,
  });

  @override
  State<RegisterMobileView> createState() => _RegisterMobileViewState();
}

class _RegisterMobileViewState extends State<RegisterMobileView> {
  late final TextEditingController nameController;

  late final TextEditingController emailController;

  late final TextEditingController passwordController;

  late final TextEditingController idController;

  late final TextEditingController phonecontroller;

  late final TextEditingController specializationController;

  bool isLoading = false;

  bool get isStudent => widget.role == "student";
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();

    emailController = TextEditingController();

    passwordController = TextEditingController();

    idController = TextEditingController();

    phonecontroller = TextEditingController();

    specializationController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();

    emailController.dispose();

    passwordController.dispose();

    idController.dispose();

    phonecontroller.dispose();

    specializationController.dispose();

    super.dispose();
  }

  void register() async {
    if (nameController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        phonecontroller.text.trim().isEmpty ||
        idController.text.trim().isEmpty) {
      showMessage(
        "Please fill all fields",
      );

      return;
    }

    final parsedId = int.tryParse(
      idController.text.trim(),
    );

    final phone = phonecontroller.text.trim();

    if (parsedId == null) {
      showMessage(
        "Student ID must be numbers only",
      );

      return;
    }

    if (parsedId.toString().length < 8) {
      showMessage(
        "Student ID must be at least 8 digits",
      );

      return;
    }

    if (phone.length != 11) {
      showMessage(
        "Phone number must be 11 digits",
      );

      return;
    }

    if (!phone.startsWith("01")) {
      showMessage(
        "Invalid phone number",
      );

      return;
    }

    final password = passwordController.text.trim();

    if (password.length < 6) {
      showMessage(
        "Password must be at least 6 characters",
      );

      return;
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      showMessage(
        "Password must contain uppercase letter",
      );

      return;
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      showMessage(
        "Password must contain a number",
      );

      return;
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      showMessage(
        "Password must contain special character",
      );

      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      final result = await AuthService.register(
        name: nameController.text.trim(),
        password: passwordController.text.trim(),
        role: widget.role,
        email: emailController.text.trim(),
        id: parsedId,
        phonenumber: phone,
        specialization: null,
      );

      final userName = result.name ?? "User";

      if (!mounted) {
        return;
      }

      showMessage(
        "Welcome $userName",
      );

      context.go(
        '/login',
        extra: widget.role,
      );
    } catch (e) {
      print("REGISTER ERROR: $e");

      String errorMessage = "Something went wrong";

      final error = e.toString();

      if (error.contains("already exists")) {
        errorMessage = "Account already exists";
      } else if (error.contains("phone")) {
        errorMessage = "Invalid phone number";
      } else if (error.contains("network")) {
        errorMessage = "No internet connection";
      } else if (error.contains("timeout")) {
        errorMessage = "Request timeout";
      }

      if (!mounted) {
        return;
      }

      showMessage(
        errorMessage,
      );
    } finally {
      if (!mounted) {
        return;
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  void showMessage(
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.role != "student") {
      return const Scaffold(
        backgroundColor: Color(0xFF0D0F1A),
        body: Center(
          child: Text(
            "Only students can register",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text(
                "Register as ${widget.role}",
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              _input(
                "Name",
                false,
                nameController,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              _input(
                "Email",
                false,
                emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              _input(
                "Student ID",
                false,
                idController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              _input(
                "Phone",
                false,
                phonecontroller,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: const TextStyle(
                      color: Colors.white70,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white70,
                      ),
                    ),
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
                ),
              ),
              const SizedBox(height: 50),
              isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF46F0D2),
                        minimumSize: const Size(300, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: register,
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  context.go(
                    '/login',
                    extra: widget.role,
                  );
                },
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
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

Widget _input(
  String label,
  bool isPassword,
  TextEditingController controller, {
  required TextInputType keyboardType,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 30,
    ),
    child: TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(
          color: Colors.white70,
        ),
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
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
