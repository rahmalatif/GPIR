import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SystemSettingsService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<Map<String, dynamic>> getSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/api/users/system-settings'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['settings'];
    }

    throw Exception('Failed to load settings');
  }

  static Future<void> updateSettings({
    required int minTeamSize,
    required int maxTeamSize,
    required String documentationDeadline,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('$baseUrl/api/users/system-settings'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "min_team_size": minTeamSize,
        "max_team_size": maxTeamSize,
        "documentation_deadline": documentationDeadline,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        jsonDecode(response.body)["message"] ??
            "Failed to update settings",
      );
    }
  }

}