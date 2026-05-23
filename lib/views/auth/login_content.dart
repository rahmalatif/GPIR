import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/design/app_image.dart';
import '../../core/logic/app_snackbar.dart';
import '../../core/logic/error_handler.dart';
import '../../services/auth_service.dart';
import '../model/user_model.dart';

class LoginContent extends StatefulWidget {
  final String role;

  const LoginContent({
    super.key,
    required this.role,
  });

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  late final TextEditingController emailController;

  late final TextEditingController passwordController;

  bool isLoading = false;
  bool obscurePassword = true;
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

  void navigateBasedOnRole(
    BuildContext context,
    UserModel user,
  ) {
    switch (user.role) {
      case 'student':
        context.go(
          '/studentDashboard',
          extra: user,
        );
        break;

      case 'doctor':
        context.go(
          '/doctorDashboard',
          extra: user,
        );
        break;

      case 'admin':
        context.go(
          '/adminDashboard',
          extra: user,
        );
        break;

      case 'library':
        context.go(
          '/libraryDashboard',
          extra: user,
        );
        break;

      case 'ta':
        context.go(
          '/taDashboard',
          extra: user,
        );
        break;

      default:
        context.go('/login');
    }
  }


  @override
  Widget build(BuildContext context) {
    final isStudent = widget.role == "student";

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 40),
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
            keyboardType:
                isStudent ? TextInputType.number : TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          Padding(

            padding:
            const EdgeInsets.symmetric(
              horizontal: 30,
            ),

            child: TextField(

              controller:
              passwordController,

              obscureText:
              obscurePassword,

              keyboardType:
              TextInputType.visiblePassword,

              style:
              const TextStyle(
                color: Colors.white,
              ),

              decoration:
              InputDecoration(

                hintText:
                "Password",

                hintStyle:
                const TextStyle(
                  color:
                  Colors.white70,
                ),

                suffixIcon:
                IconButton(

                  onPressed: () {

                    setState(() {

                      obscurePassword =
                      !obscurePassword;
                    });
                  },

                  icon: Icon(

                    obscurePassword

                        ? Icons.visibility_off

                        : Icons.visibility,

                    color:
                    Colors.white70,
                  ),
                ),

                enabledBorder:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(
                      30),

                  borderSide:
                  const BorderSide(
                    color:
                    Color(0xFF4699A8),
                  ),
                ),

                focusedBorder:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(
                      30),

                  borderSide:
                  const BorderSide(
                    color:
                    Colors.lightBlueAccent,
                  ),
                ),
              ),
            ),
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

              final input =
              emailController.text.trim();

              final password =
              passwordController.text.trim();

              // =========================
              // VALIDATION
              // =========================

              if (input.isEmpty ||
                  password.isEmpty) {

                showAppSnackBar(

                  context,

                  message:
                  "Please fill all fields",
                );

                return;
              }

              // =========================
              // STUDENT ID VALIDATION
              // =========================

              if (isStudent &&
                  int.tryParse(input) == null) {

                showAppSnackBar(

                  context,

                  message:
                  "Student ID must be numbers only",
                );

                return;
              }

              setState(() {

                isLoading = true;
              });

              try {

                final result =
                await AuthService.login(

                  role:
                  widget.role,

                  password:
                  password,

                  email:
                  isStudent
                      ? null
                      : input,

                  id:
                  isStudent
                      ? int.tryParse(input)
                      : null,
                );

                if (!mounted) {
                  return;
                }

                // =========================
                // STUDENT
                // =========================

                if (widget.role == "student") {

                  context.go(

                    '/studentDashboard',

                    extra:
                    result,
                  );

                } else {

                  final user =
                  result as UserModel;

                  navigateBasedOnRole(

                    context,

                    user,
                  );
                }

              } catch (e) {

                final message =

                ErrorHandler.getMessage(
                  e,
                );

                if (!mounted) {
                  return;
                }

                showAppSnackBar(

                  context,

                  message: message,
                );

              } finally {

                if (!mounted) {
                  return;
                }

                setState(() {

                  isLoading = false;
                });
              }
            },
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
          ),
          const SizedBox(height: 10),
          if (widget.role == "student")
            TextButton(
              onPressed: () {
                context.go(
                  '/register',
                  extra: widget.role,
                );
              },
              child: const Text(
                "Don't have an account? Register",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          const SizedBox(height: 40),
        ],
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
