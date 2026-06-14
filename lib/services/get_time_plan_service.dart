import 'dart:convert';
import 'package:http/http.dart' as http;
import '../views/model/add_time_plan.dart';
import 'auth_service.dart';

class GetTimePlanService {
  static const String baseUrl = 'https://graduationbackend-production-ec83.up.railway.app/api/timeplans/project/';

  static Future<TimePlanModel?> getTimePlan(String projectId) async {
    final response = await http.get(
      Uri.parse('$baseUrl$projectId'),
      headers: {
        'Authorization': 'Bearer ${AuthService.token}',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print("Decoded Data = $data");

      if (data['plan'] == null) {
        print("Plan is null");
        return null;
      }

      return TimePlanModel.fromJson(data);
    }else if (response.statusCode == 404) {
      return null;
    }
    throw Exception('Failed To Load Time Plan');
  }
}