import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://stipulatory-semidefensively-eveline.ngrok-free.dev";


  static Future<http.Response> register({
    required String name,
    required String password,
    required String role,
    String? email,
    int? id,
  }) async {
    String endpoint;

    if (role == "student") {
      endpoint = "/api/students/add";
    } else {
      endpoint = "/api/users/add";
    }

    final url = Uri.parse("$baseUrl$endpoint");

    return await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        role == "student"
            ? {
          "id": id,
          "password": password,
          "role": role,
        }
            : {
          "name": name,
          "email": email,
          "password": password,
          "role": role,
        },
      ),
    );
  }


  static Future<http.Response> login({
    required String password,
    required String role,
    String? email,
    int? id,
  }) async {
    String endpoint;

    if (role == "student") {
      endpoint = "/api/students/login";
    } else {
      endpoint = "/api/users/login";
    }

    final url = Uri.parse("$baseUrl$endpoint");

    return await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        role == "student"
            ? {
          "id": id,
          "password": password,
        }
            : {
          "email": email,
          "password": password,
        },
      ),
    );
  }
}