import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class TeamInvitationService {
  static const String url =
      'https://graduationbackend-production-ec83.up.railway.app/api/students/send-invitation';

  static Future<void> sendInvitation(
      String studentId,
      ) async {

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${AuthService.token}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "receiver_id": studentId,
      }),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception(response.body);
    }
  }
}