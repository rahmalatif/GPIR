import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class LibraryCurrentProjectsService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<List<dynamic>> getCurrentProjects() async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/api/users/library/current-projects",
      ),
      headers: {
        "Authorization": "Bearer ${AuthService.token}",
        "Content-Type": "application/json",
      },
    );

    print(
      "CURRENT PROJECTS STATUS: "
      "${response.statusCode}",
    );

    print(
      "CURRENT PROJECTS RESPONSE: "
      "${response.body}",
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(
        response.body,
      );

      return data["projects"] ?? [];
    }

    throw Exception(
      response.body,
    );
  }
}
