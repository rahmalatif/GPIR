import 'dart:convert';
import 'package:http/http.dart' as http;
import '../views/model/invitation.dart';
import 'auth_service.dart';

class GetInvitationsService {
  static const String url =
      'https://graduationbackend-production-ec83.up.railway.app/api/students/invitations';

  static Future<List<InvitationModel>> getInvitations() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${AuthService.token}',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data['invitations'] as List)
          .map(
            (e) => InvitationModel.fromJson(e),
          )
          .toList();
    }
    print(response.body);
    throw Exception(
      response.body,
    );
  }
}
