import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApproveTaTimePlanService {
  static Future<bool> approve(String planId) async {
    final response = await http.put(
      Uri.parse(
        'https://graduationbackend-production-ec83.up.railway.app/api/timeplans/approve-ta/$planId',
      ),
      headers: {
        'Authorization': 'Bearer ${AuthService.token}',
      },
    );

    print(response.body);

    return response.statusCode == 200;
  }
}