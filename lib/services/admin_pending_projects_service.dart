import 'dart:convert';

import 'package:http/http.dart'
as http;

import 'auth_service.dart';

class AdminPendingProjectsService {

  static const String baseUrl =

      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<List<dynamic>>
  getPendingProjects() async {

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
          "ADMIN PENDING STATUS: "
              "${response.statusCode}");

      print(
          "ADMIN PENDING RESPONSE: "
              "${response.body}");

      if (response.statusCode ==
          200) {

        final data =
        jsonDecode(
            response.body);

        return data[
        'projectsWithoutCode']

            ??
            [];
      }

      return [];

    } catch (e) {

      print(
          "ADMIN PENDING ERROR: $e");

      return [];
    }
  }
}