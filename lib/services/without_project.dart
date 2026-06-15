import 'dart:convert';
import 'package:http/http.dart' as http;
import '../views/model/team_without_project.dart';
import 'auth_service.dart';

class WithoutProjectService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  Future<List<TeamWithoutProjectModel>> getTeamsWithoutProjects() async {
    try {
      final token = AuthService.token;

      final response = await http.get(
        Uri.parse('$baseUrl/api/teams/no-project'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data
            .map(
              (e) => TeamWithoutProjectModel.fromJson(e),
            )
            .toList();
      } else {
        throw Exception(
          'Failed to load teams: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception(
        'Error loading teams: $e',
      );
    }
  }
}
