import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class DoctorProjectStatusService {
  static const String baseUrl = "https://graduationbackend-production-ec83.up.railway.app";

  static Future<bool> updateProjectStatus({
    required String projectId,
    required String status,
  }) async {
    try {
      final token = AuthService.token;

      final response = await http.put(
        Uri.parse(
          '$baseUrl/api/projects/update-status/$projectId',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "status": status,
        }),
      );
      print(response.body);
      print("UPDATE STATUS CODE: "
          "${response.statusCode}");

      print("UPDATE STATUS RESPONSE: "
          "${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("UPDATE STATUS ERROR: $e");

      return false;
    }
  }
}
