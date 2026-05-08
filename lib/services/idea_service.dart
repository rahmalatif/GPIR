import 'dart:convert';

import 'package:http/http.dart'
as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../views/model/project_idea.dart';

class IdeaServices {

  final String baseUrl =

      "https://graduation-backend-orcin.vercel.app";

  Future<dynamic> checkSimilarity(

      ProjectIdea idea,

      ) async {

    try {

      final prefs =

      await SharedPreferences
          .getInstance();

      final token =
      prefs.getString('token');

      print("TOKEN: $token");

      print("REQUEST SENT");

      final response =

      await http.post(

        Uri.parse(
            '$baseUrl/api/projects/add'),

        headers: {

          'Content-Type':
          'application/json',

          'Authorization':
          'Bearer $token',
        },

        body: jsonEncode(
          idea.toJson(),
        ),

      ).timeout(

        const Duration(
            seconds: 20),
      );

      print(
          "STATUS CODE: ${response.statusCode}");

      print(
          "RESPONSE: ${response.body}");

      dynamic data;

      try {

        data =
            jsonDecode(
                response.body);

      } catch (e) {

        data = {
          "message":
          response.body,
        };
      }

      return data;

    } catch (e) {

      print(
          "API ERROR: $e");

      rethrow;
    }
  }
}