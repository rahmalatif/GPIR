import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class DoctorProjectDetailsService {
  static const String baseUrl = "https://graduation-backend-orcin.vercel.app";

  static Future<Map<String, dynamic>> getProjectDetails(
    String id,
  ) async {
    try {
      final token = AuthService.token;

      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/projects/$id',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("PROJECT DETAILS STATUS: ${response.statusCode}");

      print("PROJECT DETAILS RESPONSE: ${response.body}");

      return jsonDecode(
        response.body,
      );
    } catch (e) {
      print("PROJECT DETAILS ERROR: $e");

      return {};
    }
  }
}
