import 'dart:convert';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class LibraryProfileService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<Map<String, dynamic>> getProfile() async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/api/users/profile",
      ),
      headers: {
        "Authorization": "Bearer ${AuthService.token}",
        "Content-Type": "application/json",
      },
    );

    print(
      "PROFILE STATUS: "
      "${response.statusCode}",
    );

    print(
      "PROFILE RESPONSE: "
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
