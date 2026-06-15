import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class LibraryProjectService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<void> addOldProject({
    required String projectCode,
    required String title,
    required String description,
    required List<String> specialization,
    required List<String> tools,
    required String doctor,
    required String ta,
    required int year,
    required String futureWork,
  }) async {
    final response = await http.post(
      Uri.parse(
        "$baseUrl/api/users/library/old-project",
      ),
      headers: {
        "Authorization": "Bearer ${AuthService.token}",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "project_code": projectCode,
        "title": title,
        "description": description,
        "Specialization": specialization.join(', '),
        "Tools": tools.join(', '),
        "Doctor": doctor,
        "TA": ta,
        "Year": year.toString(),
        "FutureWork": futureWork,
      }),
    );

    print(
      "ADD OLD PROJECT STATUS: "
      "${response.statusCode}",
    );

    print(
      "ADD OLD PROJECT RESPONSE: "
      "${response.body}",
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
        response.body,
      );
    }
  }
}
