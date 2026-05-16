import 'dart:convert';

import 'package:http/http.dart'
as http;

import 'auth_service.dart';

class TAProjectStatusService {

  static const String baseUrl =

      "https://graduation-backend-orcin.vercel.app";

  static Future<bool>
  updateProjectStatus({

    required String projectId,

    required String status,
  }) async {

    try {

      final token =
          AuthService.token;

      final response =
      await http.put(

        Uri.parse(
          '$baseUrl/api/projects/update-status/$projectId',
        ),

        headers: {

          'Authorization':
          'Bearer $token',

          'Content-Type':
          'application/json',
        },

        body: jsonEncode({

          "status": status,
        }),
      );

      print(
          "TA UPDATE STATUS: "
              "${response.statusCode}");

      print(
          "TA UPDATE RESPONSE: "
              "${response.body}");

      return response.statusCode == 200;

    } catch (e) {

      print(
          "TA UPDATE ERROR: $e");

      return false;
    }
  }
}