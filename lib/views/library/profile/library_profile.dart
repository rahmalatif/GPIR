import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/auth_service.dart';
import '../../../services/library_profile_services.dart';
import '../../model/library.dart';

class LibraryProfileView extends StatefulWidget {
  const LibraryProfileView({
    super.key,
  });

  @override
  State<LibraryProfileView> createState() => _LibraryProfileViewState();
}

class _LibraryProfileViewState extends State<LibraryProfileView> {
  late Future<Map<String, dynamic>> profileFuture;

  @override
  void initState() {
    super.initState();

    profileFuture = LibraryProfileService.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: FutureBuilder<Map<String, dynamic>>(
        future: profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Failed to load profile",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          final data = snapshot.data ?? {};

          final user = data["user"] ?? data;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    user["name"] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),
                _infoItem(
                  "Email",
                  user["email"] ?? "",
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      AuthService.token = null;

                      context.go(
                        '/roleSelection',
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                    ),
                    label: const Text(
                      "Logout",
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _infoItem(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
