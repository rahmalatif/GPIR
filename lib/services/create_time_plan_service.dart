import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class CreateTimePlanService {
  static const String url = 'https://graduationbackend-production-ec83.up.railway.app/api/timeplans/add/';

  static Future<void> createTimePlan({
    required String projectId,
    required List<Map<String, dynamic>> tasks,
  }) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${AuthService.token}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "project_id": projectId,
        "tasks": tasks,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
  }
}