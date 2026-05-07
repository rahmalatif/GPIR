import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../views/model/project_idea.dart';

class IdeaServices {
  final String baseUrl =
      "https://stipulatory-semidefensively-eveline.ngrok-free.dev/api";

  Future<dynamic> checkSimilarity(ProjectIdea idea) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/projects/add'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(idea.toJson()),
    );

    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE: ${response.body}");
    print(jsonEncode(idea.toJson()));
    return jsonDecode(response.body);
  }
}
