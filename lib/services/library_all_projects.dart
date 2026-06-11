import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class LibraryAllProjectsService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<List<dynamic>> getProjects() async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/api/users/library/projects",
      ),
      headers: {
        "Authorization": "Bearer ${AuthService.token}",
        "Content-Type": "application/json",
      },
    );

    print(
      "ALL PROJECTS STATUS: "
      "${response.statusCode}",
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
