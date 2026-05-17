import 'package:http/http.dart' as http;

import 'auth_service.dart';

class LeaveTeamService {
  static const String baseUrl = "https://graduationbackend-production-ec83.up.railway.app";

  static Future<bool> leaveTeam() async {
    try {
      final response = await http.put(
        Uri.parse(
          '$baseUrl/api/teams/leave',
        ),
        headers: {
          'Authorization': 'Bearer ${AuthService.token}',
          'Content-Type': 'application/json',
        },
      );

      print("LEAVE TEAM STATUS: "
          "${response.statusCode}");

      print("LEAVE TEAM RESPONSE: "
          "${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("LEAVE TEAM ERROR: $e");

      return false;
    }
  }
}
