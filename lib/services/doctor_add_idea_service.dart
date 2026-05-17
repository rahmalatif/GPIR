import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class DoctorAddIdeaService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<Map<String, dynamic>> checkSimilarity({
    required String title,
    required String description,
    required List<String> specialization,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/api/ideas/check-idea-similarity',
        ),
        headers: {
          'Authorization': 'Bearer ${AuthService.token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "title": title,
          "description": description,
          "specialization": specialization,
        }),
      );

      print("SIMILARITY STATUS: "
          "${response.statusCode}");

      print("SIMILARITY RESPONSE: "
          "${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return {};
    } catch (e) {
      print("SIMILARITY ERROR: $e");

      return {};
    }
  }

  static Future<bool> addIdea({
    required String title,
    required String description,
    required List<String> specialization,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/api/ideas/add-idea',
        ),
        headers: {
          'Authorization': 'Bearer ${AuthService.token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "title": title,
          "description": description,
          "specialization": specialization,
        }),
      );

      print("ADD IDEA STATUS: "
          "${response.statusCode}");

      print("ADD IDEA RESPONSE: "
          "${response.body}");

      return response.statusCode == 201;
    } catch (e) {
      print("ADD IDEA ERROR: $e");

      return false;
    }
  }
}
