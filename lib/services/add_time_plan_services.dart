import 'dart:convert';
import 'package:http/http.dart' as http;

import '../views/model/add_time_plan.dart';
import 'auth_service.dart';

class TimePlanService {

  static const String url =
      'https://graduationbackend-production-ec83.up.railway.app/api/timeplan/add';

  static Future<void> createTimePlan({
    required String projectId,

    required List<TimePlanModel> tasks,
  }) async {

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization':
        'Bearer ${AuthService.token}',
        'Content-Type':
        'application/json',
      },
      body: jsonEncode({
        "project_id": projectId,

      }),
    );

    print(response.body);

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception(response.body);
    }
  }
}