import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class AdminProjectDetailsService {
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

      print("ADMIN DETAILS STATUS: "
          "${response.statusCode}");

      print("ADMIN DETAILS RESPONSE: "
          "${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return {};
    } catch (e) {
      print("ADMIN DETAILS ERROR: $e");

      return {};
    }
  }

  static Future<bool> approveProject(
    String id,
      String projectCode,
  ) async {
    try {
      final token = AuthService.token;

      final response =
      await http.put(

        Uri.parse(
          '$baseUrl/api/projects/admin-approve/$id',
        ),

        headers: {

          'Authorization':
          'Bearer $token',

          'Content-Type':
          'application/json',
        },

        body: jsonEncode({

          "project_code":
          projectCode,
        }),
      );

      print("ADMIN APPROVE STATUS: "
          "${response.statusCode}");

      print("ADMIN APPROVE RESPONSE: "
          "${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("ADMIN APPROVE ERROR: $e");

      return false;
    }
  }
}
