import 'dart:convert';

import 'package:http/http.dart'
as http;

import 'auth_service.dart';

class DashboardService {

  static const String baseUrl =

      "https://graduation-backend-orcin.vercel.app";

  static Future<Map<String, dynamic>>
  getDashboard() async {

    try {

      final token =
          AuthService.token;

      print(
          "DASHBOARD TOKEN: "
              "$token");

      final response =
      await http.get(

        Uri.parse(
          '$baseUrl/api/students/dashboard',
        ),

        headers: {

          'Authorization':
          'Bearer $token',

          'Content-Type':
          'application/json',
        },
      );

      print(
          "DASHBOARD STATUS: "
              "${response.statusCode}");

      print(
          "DASHBOARD RESPONSE: "
              "${response.body}");

      return jsonDecode(
        response.body,
      );

    } catch (e) {

      print(
          "DASHBOARD ERROR: $e");

      return {};
    }
  }
}