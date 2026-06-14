import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/auth_service.dart';
import '../../../services/library_profile_services.dart';
import '../../model/library.dart';

class LibraryProfileWebView extends StatefulWidget {
  const LibraryProfileWebView({super.key,});


  @override
  State<LibraryProfileWebView> createState() => _LibraryProfileViewState();
}

class _LibraryProfileViewState extends State<LibraryProfileWebView> {
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
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final data = snapshot.data ?? {};
          final user = data["user"] ?? data;

          return LayoutBuilder(
            builder: (context, constraints) {
              final bool isWeb = constraints.maxWidth > 768;

              return Center(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: isWeb ? 500 : double.infinity),
                    padding: isWeb ? const EdgeInsets.all(32) : EdgeInsets.zero,
                    decoration: isWeb
                        ? BoxDecoration(
                            color: const Color(0xFF1A1D2E),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.03)),
                          )
                        : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isWeb) const SizedBox(height: 40),
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
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            user["name"] ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        if (isWeb) ...[
                          const Divider(color: Colors.white10, height: 1),
                          const SizedBox(height: 24),
                        ],
                        const SizedBox(height: 20),
                        _infoItem("Email", user["email"] ?? ""),
                        const SizedBox(height: 40),
                        Center(
                          child: SizedBox(
                            width: isWeb ? double.infinity : 200,
                            height: 48,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                AuthService.token = null;
                                context.go('/roleSelection');
                              },
                              icon:
                                  const Icon(Icons.logout, color: Colors.white),
                              label: const Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
      const SizedBox(height: 6),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0F1A).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.03)),
        ),
        child: Text(
          value.isEmpty ? "-" : value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
