import 'dart:convert';
import 'package:http/http.dart' as http;

import '../views/model/project.dart';

class IdeaServices{

  final String baseUrl =
      "https://stipulatory-semidefensively-eveline.ngrok-free.dev/api";


  Future<double> checkSimilarity(ProjectIdea idea) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ideas'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "Name": idea.name,
        "Tools": idea.technologies,
        "Specialization": idea.specializations,
        "Introduction": idea.introduction,
      }),
    );
    if (response.statusCode != 200 && response.statusCode != 400) {
      throw Exception("Backend error");
    }

    final data = jsonDecode(response.body);

    if (data.containsKey("similarity")) {
      return (data["similarity"] as num).toDouble();
    }

    if (data["duplicates"] != null && data["duplicates"].isNotEmpty) {
      return (data["duplicates"][0]["similarity_percentage"] as num).toDouble();
    }

    return 0;
  }
}
