import 'package:http/http.dart' as http;

import 'auth_service.dart';

class StopLookingForTeamService {

  static const String url =
      'https://graduationbackend-production-ec83.up.railway.app/api/students/stop-looking-for-team';

  static Future<void> stopLooking() async {

    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${AuthService.token}',
      },
    );

    print(response.body);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}