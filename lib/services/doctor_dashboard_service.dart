import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class DoctorDashboardService {
  static const String baseUrl = "https://graduation-backend-orcin.vercel.app";

  static Future<Map<String, dynamic>> getDashboard() async {
    try {
      final token = AuthService.token;
      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/users/doctor/dashboard',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("DOCTOR DASHBOARD STATUS: ${response.statusCode}");
      print("DOCTOR DASHBOARD RESPONSE: ${response.body}");

      return jsonDecode(
        response.body,
      );
    } catch (e) {
      print("DOCTOR DASHBOARD ERROR: $e");

      return {};
    }
  }
}
