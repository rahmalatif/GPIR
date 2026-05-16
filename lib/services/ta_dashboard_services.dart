
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TeacherAssistantDashboardService {
  static const String baseUrl =
      'YOUR_BASE_URL/api/projects/ta/dashboard';

  static Future<Map<String, dynamic>> getDashboard() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      debugPrint(
        "TA DASHBOARD STATUS: ${response.statusCode}",
      );

      debugPrint(
        "TA DASHBOARD RESPONSE: ${response.body}",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data;
      }

      return {};
    } catch (e) {
      debugPrint(
        "TA DASHBOARD ERROR: $e",
      );

      return {};
    }
  }
}