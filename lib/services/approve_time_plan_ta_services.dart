import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApproveTimePlanService {
  static const String baseUrl = 'https://graduationbackend-production-ec83.up.railway.app/api/timeplans/approve-ta/';

  static Future<void> approvePlanByTA(String planId) async {
    final response = await http.put(
      Uri.parse('$baseUrl$planId'),
      headers: {
        'Authorization': 'Bearer ${AuthService.token}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to approve time plan');
    }
  }
}