import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../services/auth_service.dart';
import '../../views/model/student.dart';
import '../../views/model/user_model.dart';

class ApiService {
  static const String baseUrl =
      "https://stipulatory-semidefensively-eveline.ngrok-free.dev";

  static Future<http.Response> register({
    required String name,
    required String password,
    required String role,
    String? email,
    int? id,
    required int phonenumber,
  }) async {
    String endpoint;
    Map<String, dynamic> body;

    if (role == "student") {
      endpoint = "/api/students/add";
      body = {
        "name": name,
        "collegeCode": id,
        "password": password,
        "phone" : phonenumber
      };
    } else {
      endpoint = "/api/users/add";
      body = {
        "name": name,
        "email": email,
        "password": password,
        "role": role,
      };
    }

    final url = Uri.parse("$baseUrl$endpoint");

    print("REGISTER BODY: $body");
    print("ENDPOINT: $endpoint");

    try {
      final response = await http
          .post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: 10));

      print("REGISTER RESPONSE: ${response.body}");

      return response;
    } catch (e) {
      print("REGISTER ERROR: $e");
      throw Exception("Server not responding");
    }
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

    final body = role == "student"
        ? {
      "collegeCode": id,
      "password": password,
    }
        : {
      "email": email,
      "password": password,
    };

    print("LOGIN BODY: $body");

    try {
      final response = await http
          .post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: 10));

      print("LOGIN RESPONSE: ${response.body}");

      return response;
    } catch (e) {
      print("LOGIN ERROR: $e");
      throw Exception("Server not responding");
    }
  }

  static Future<Map<String, dynamic>> addProject({
    required String token,
    required Map<String, dynamic> projectData,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/projects/add'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(projectData),
    );

    print("REQUEST BODY: $projectData");
    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE: ${response.body}");

    return jsonDecode(response.body);
  }
}