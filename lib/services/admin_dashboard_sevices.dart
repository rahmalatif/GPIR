import 'dart:convert';

import 'package:http/http.dart'
as http;

import 'auth_service.dart';

class AdminDashboardService {

  static const String baseUrl =

      "https://graduation-backend-orcin.vercel.app";

  static Future<Map<String, dynamic>>
  getDashboard() async {

    try {

      final token =
          AuthService.token;

      final response =
      await http.get(

        Uri.parse(
          '$baseUrl/api/projects/admin/dashboard',
        ),

        headers: {

          'Authorization':
          'Bearer $token',

          'Content-Type':
          'application/json',
        },
      );

      print(
          "ADMIN DASHBOARD STATUS: "
              "${response.statusCode}");

      print(
          "ADMIN DASHBOARD RESPONSE: "
              "${response.body}");

      if (response.statusCode ==
          200) {

        return jsonDecode(
            response.body);
      }

      return {};

    } catch (e) {

      print(
          "ADMIN DASHBOARD ERROR: $e");

      return {};
    }
  }
}