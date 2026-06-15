import 'dart:convert';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class RejectTaTimePlanService {
  static Future<bool> reject({
    required String planId,
    required String comment,
  }) async {
    final response = await http.put(
      Uri.parse(
        'https://graduationbackend-production-ec83.up.railway.app/api/timeplans/reject-ta/$planId',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthService.token}',
      },
      body: jsonEncode({
        "comment": comment,
      }),
    );

    print(response.body);

    return response.statusCode == 200;
  }
}
