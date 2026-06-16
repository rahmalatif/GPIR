import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ManagerDashboardService {
  static const String baseUrl =
      "https://graduationbackend-production-ec83.up.railway.app";

  static Future<Map<String, dynamic>> getDashboard() async {
    try {
      print('Dashboard Request Started');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      print('TOKEN = $token');

      final response = await http.get(
        Uri.parse('$baseUrl/api/users/manager/dashboard'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('STATUS = ${response.statusCode}');
      print('BODY = ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception(response.body);
    } catch (e) {
      print('DASHBOARD ERROR = $e');
      rethrow;
    }
  }}
