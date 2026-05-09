import 'dart:convert';

import 'package:http/http.dart' as http;

class RecommendationService {
  static const String baseUrl = "https://graduation-backend-orcin.vercel.app";

  static Future<List<dynamic>> recommendIdeas({
    required List<String> specializations,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/api/ideas/recommend-ideas',
        ),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "specializations": specializations,
        }),
      );

      print("RECOMMEND STATUS: "
          "${response.statusCode}");

      print("RECOMMEND RESPONSE: "
          "${response.body}");

      final data = jsonDecode(response.body);

      return data['ideas'] ?? [];
    } catch (e) {
      print("RECOMMEND ERROR: $e");

      return [];
    }
  }
}
