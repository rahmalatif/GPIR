import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../views/model/doctor_with_projects_model.dart';
import '../views/model/ta_with_projects_model.dart';

class ManagerService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<List<DoctorWithProjectsModel>>
  getDoctorsWithProjects() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(
        '$baseUrl/api/users/doctors-with-projects',
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data['doctors'] as List)
          .map(
            (e) => DoctorWithProjectsModel.fromJson(e),
      )
          .toList();
    }

    throw Exception(
      'Failed to load doctors',
    );
  }
  static Future<List<TaWithProjectsModel>>
  getTasWithProjects() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(
        '$baseUrl/api/users/tas-with-projects',
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data['tas'] as List)
          .map(
            (e) => TaWithProjectsModel.fromJson(e),
      )
          .toList();
    }

    throw Exception('Failed to load TAs');
  }
}