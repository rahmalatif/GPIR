import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class LeaveTeamService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<bool> leaveTeam({
    String? newLeaderId,
  }) async {
    try {
      final response = await http.put(
        Uri.parse(
          '$baseUrl/api/teams/leave',
        ),
        headers: {
          'Authorization': 'Bearer ${AuthService.token}',
          'Content-Type': 'application/json',
        },

        body: jsonEncode({
          if (newLeaderId != null) "new_leader_id": newLeaderId,
        }),
      );

      print("LEAVE TEAM STATUS: "
          "${response.statusCode}");

      print("LEAVE TEAM RESPONSE: "
          "${response.body}");

      if (response.statusCode == 200) {
        return true;
      }

      throw Exception(
        response.body,
      );
    } catch (e) {
      print("LEAVE TEAM ERROR: $e");

      rethrow;
    }
  }
}
