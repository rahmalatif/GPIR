import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../services/auth_service.dart';


class JoinStudentService {
  static const String baseUrl =
      'https://graduationbackend-production-ec83.up.railway.app/api/students/looking-for-team';

  static Future<void> joinAsStudent({
    required String specialization,
  }) async {
    final token = AuthService.token;

    final response = await http.patch(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "specialization": specialization,
      }),
    );

    print(response.body);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}