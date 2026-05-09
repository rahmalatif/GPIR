import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class StudentProfileService {
  static const String baseUrl = "https://graduation-backend-orcin.vercel.app";

  static Future<Map<String, dynamic>> getProfile() async {
    try {
      final token = AuthService.token;

      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/students/profile',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("PROFILE STATUS: ${response.statusCode}");

      print("PROFILE RESPONSE: ${response.body}");

      return jsonDecode(
        response.body,
      );
    } catch (e) {
      print("PROFILE ERROR: $e");

      return {};
    }
  }
}
