import 'dart:convert';
import 'package:http/http.dart' as http;
import '../views/model/find_student.dart';
import 'auth_service.dart';

class FindStudentService {
  static const String baseUrl =
      'https://graduationbackend-production-ec83.up.railway.app/api/students/available';

  static Future<List<FindStudentModel>> getStudents() async {
    final token = AuthService.token;

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data['students'] as List)
          .map((student) => FindStudentModel.fromJson(student))
          .toList();
    }

    throw Exception(
      'Failed to load students: ${response.statusCode}',
    );
  }
}