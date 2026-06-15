import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class DocumentationReminderService {
  static Future<void> sendReminder(String projectId) async {


    final token = await AuthService.token;

    final response = await http.post(
      Uri.parse(
        "https://your-api-url/api/projects/send-documentation-reminder",
      ),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "projectId": projectId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to send reminder");
    }
  }
}