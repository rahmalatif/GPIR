import 'dart:convert';

import 'package:http/http.dart' as http;

class DoctorService {
  static const String baseUrl = "https://graduationbackend-production-ec83.up.railway.app";

  static Future<List<dynamic>> getDoctors() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/users/doctors',
        ),
      );

      print("DOCTORS STATUS: ${response.statusCode}");

      print("DOCTORS RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("DR. $data");
        return data['doctors'];
      }

      return [];
    } catch (e) {
      print("DOCTORS ERROR: $e");

      return [];
    }
  }
}
