import 'dart:convert';

import 'package:http/http.dart'
as http;

import 'auth_service.dart';

class RecommendSelectService {

  static const String baseUrl =

      "https://graduation-backend-orcin.vercel.app";

  static Future<bool>
  selectIdea(
      String ideaId,
      ) async {

    try {

      final token =
          AuthService.token;

      final response =
      await http.put(

        Uri.parse(
          '$baseUrl/api/ideas/select-idea/$ideaId',
        ),

        headers: {

          'Authorization':
          'Bearer $token',

          'Content-Type':
          'application/json',
        },
      );

      print(
          "SELECT IDEA STATUS: "
              "${response.statusCode}");

      print(
          "SELECT IDEA RESPONSE: "
              "${response.body}");

      return response.statusCode >= 200
          && response.statusCode < 300;

    } catch (e) {

      print(
          "SELECT IDEA ERROR: $e");

      return false;
    }
  }
}