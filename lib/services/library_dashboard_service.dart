import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class LibraryDashboardService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<Map<String, dynamic>> getDashboard() async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/api/users/library/dashboard",
      ),
      headers: {
        "Authorization": "Bearer ${AuthService.token}",
        "Content-Type": "application/json",
      },
    );

    print(
      "LIBRARY DASHBOARD STATUS: "
      "${response.statusCode}",
    );

    print(
      "LIBRARY DASHBOARD RESPONSE: "
      "${response.body}",
    );

    if (response.statusCode == 200) {
      return jsonDecode(
        response.body,
      );
    }

    throw Exception(
      response.body,
    );
  }
}
