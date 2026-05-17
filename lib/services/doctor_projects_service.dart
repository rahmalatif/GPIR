import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class DoctorProjectsService {
  static const String baseUrl = "https://graduationbackend-production-ec83.up.railway.app";

  static Future<List<dynamic>> getProjects() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/users/doctor/dashboard',
        ),
        headers: {
          'Authorization': 'Bearer ${AuthService.token}',
        },
      );

      print("PROJECTS STATUS: "
          "${response.statusCode}");

      print("PROJECTS RESPONSE: "
          "${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data['recentIdeas'] ?? [];
      }

      return [];
    } catch (e) {
      print("PROJECTS ERROR: $e");

      return [];
    }
  }
}
