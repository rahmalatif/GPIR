import 'dart:convert';

import 'package:http/http.dart'
as http;

import 'auth_service.dart';

class TAProjectsService {

  static const String baseUrl =

      "https://graduation-backend-orcin.vercel.app";

  static Future<List<dynamic>>
  getProjects() async {

    try {

      final token =
          AuthService.token;

      final response =
      await http.get(

        Uri.parse(
          '$baseUrl/api/projects',
        ),

        headers: {

          'Authorization':
          'Bearer $token',

          'Content-Type':
          'application/json',
        },
      );

      print(
          "TA PROJECTS STATUS: "
              "${response.statusCode}");

      print(
          "TA PROJECTS RESPONSE: "
              "${response.body}");

      if (response.statusCode == 200) {

        final data =
        jsonDecode(
            response.body);

        return data['projects']
            ?? [];
      }

      return [];

    } catch (e) {

      print(
          "TA PROJECTS ERROR: $e");

      return [];
    }
  }
}