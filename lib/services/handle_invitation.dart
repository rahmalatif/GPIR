import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class HandleInvitationService {
  static const String url =
      'https://graduationbackend-production-ec83.up.railway.app/api/students/handle-invitation';

  static Future<void> handleInvitation({
    required String invitationId,
    required String action,
  }) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${AuthService.token}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "invitation_id": invitationId,
        "action": action,
      }),
    );

    print(response.body);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}
