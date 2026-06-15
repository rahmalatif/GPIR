import 'dart:convert';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class AddTaskService {
  static Future<bool> addTask({
    required String planId,
    required String title,
    required String description,
    required String deadline,
  }) async {
    final response = await http.put(
      Uri.parse(
        'https://graduationbackend-production-ec83.up.railway.app/api/timeplans/add-task/$planId',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthService.token}',
      },
      body: jsonEncode({
        "title": title,
        "description": description,
        "deadline": deadline,
      }),
    );

    print(response.body);

    return response.statusCode == 200;
  }
}
