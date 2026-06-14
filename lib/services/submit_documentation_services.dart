import 'dart:convert';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class LibrarySubmitDocumentationService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<void> submitDocumentation(
    String projectId,
  ) async {
    final response = await http.patch(
      Uri.parse(
        "$baseUrl/api/users/library/projects/$projectId/submit",
      ),
      headers: {
        "Authorization": "Bearer ${AuthService.token}",
        "Content-Type": "application/json",
      },
    );

    print(
      "SUBMIT DOC STATUS: "
      "${response.statusCode}",
    );

    print(
      "SUBMIT DOC RESPONSE: "
      "${response.body}",
    );

    if (response.statusCode != 200) {
      throw Exception(
        jsonDecode(
              response.body,
            )["message"] ??
            "Failed to submit documentation",
      );
    }
  }
}
