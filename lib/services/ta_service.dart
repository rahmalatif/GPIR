import 'dart:convert';

import 'package:http/http.dart' as http;

class TAService {
  static const String baseUrl = "https://graduation-backend-orcin.vercel.app";

  static Future<List<dynamic>> getTAs() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/users/tas',
        ),
      );

      print("TA STATUS: ${response.statusCode}");

      print("TA RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data['tas'] ?? [];
      }

      return [];
    } catch (e) {
      print("TA ERROR: $e");

      return [];
    }
  }
}
