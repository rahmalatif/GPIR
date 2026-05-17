import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class DoctorMyIdeasService {
  static const String baseUrl = "https://graduationbackend-production-ec83.up.railway.app";

  static Future<List<dynamic>> getMyIdeas() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/ideas/my-ideas',
        ),
        headers: {
          'Authorization': 'Bearer ${AuthService.token}',
          'Content-Type': 'application/json',
        },
      );

      print("MY IDEAS STATUS: "
          "${response.statusCode}");

      print("MY IDEAS RESPONSE: "
          "${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data['ideas'] ?? [];
      }

      return [];
    } catch (e) {
      print("MY IDEAS ERROR: $e");

      return [];
    }
  }
  static Future<bool> deleteIdea(String ideaId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/ideas/delete-idea/$ideaId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthService.token}',
      },
    );

    return response.statusCode == 200;
  }
}
