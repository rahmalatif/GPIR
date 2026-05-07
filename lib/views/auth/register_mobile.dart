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
  late final TextEditingController idController;
  late final TextEditingController phonecontroller;
  bool isLoading = false;

  bool get isStudent => widget.role == "student";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    idController = TextEditingController();
    phonecontroller = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    idController.dispose();
    super.dispose();
    phonecontroller = TextEditingController();
  }

  void register() async {
    if (nameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        (isStudent && idController.text.isEmpty) ||
        (!isStudent && emailController.text.isEmpty)) {
      showMessage("Please fill all fields");
      return;
    }

    try {
      final parsedId = isStudent ? int.tryParse(idController.text) : null;
      final parsedPhone = int.tryParse(phonecontroller.text);

      if (isStudent && parsedId == null) {
        showMessage("ID must be a number");
        return;
      }
      setState(() => isLoading = true);

      if (parsedPhone == null) {
        showMessage("Phone must be a number");
        return;
      }

      final result = await AuthService.register(
        name: nameController.text,
        password: passwordController.text,
        role: widget.role,
        email: isStudent ? null : emailController.text,
        id: parsedId,
        phonenumber: parsedPhone,
      );

      final userName = result.name ?? "User";

      showMessage("Welcome $userName");
    } catch (e) {
      print("ERROR: $e");
      showMessage("Something went wrong");
    }
    context.go('/login', extra: widget.role);

    if (!mounted) return;

    setState(() => isLoading = false);
  }

  void showMessage(String message) {
    print(message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
              Text(
                "Register as ${widget.role}",
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 30),
              _input("Name", false, nameController,
                  keyboardType: TextInputType.name),
              const SizedBox(height: 20),
              _input(
                isStudent ? "Student ID" : "Email",
                false,
                isStudent ? idController : emailController,
                keyboardType: isStudent
                    ? TextInputType.number
                    : TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              _input("name", false, phonecontroller,
                  keyboardType: TextInputType.name),
              const SizedBox(height: 20),
              _input("Password", true, passwordController,
                  keyboardType: TextInputType.visiblePassword),
              const SizedBox(height: 50),
              isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
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
      keyboardType: keyboardType,
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
