import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class TaApprovedProjectsService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<List<dynamic>> getApprovedProjects() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/api/projects/ta/approved-projects"),
        headers: {
          'Authorization': 'Bearer ${AuthService.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['projects'] ?? [];
      } else {
        throw Exception('Failed to load approved projects: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching projects: $e');
    }
  }
}