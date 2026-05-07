import 'dart:convert';
import '../core/logic/api_service.dart';
import '../core/logic/cache_helper.dart';
import '../views/model/student.dart';
import '../views/model/user_model.dart';

class AuthService {
  static String? token;
  static bool isLeader = false;

  static Future<dynamic> register({
    required String name,
    required String password,
    required String role,
    String? email,
    int? id,
    required int phonenumber,
  }) async {
    final response = await ApiService.register(
      name: name,
      email: email,
      password: password,
      role: role,
      id: id,
      phonenumber : phonenumber,
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      if (role == "student") {
        return Student.fromJson(data["student"]);
      } else {
        return UserModel.fromJson(data["user"]);
      }
    } else {
      throw Exception(data["message"] ?? "Register failed");
    }
  }

  static Future<dynamic> login({
    required String password,
    required String role,
    String? email,
    int? id,
  }) async {
    final response = await ApiService.login(
      password: password,
      role: role,
      email: email,
      id: id,
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      token = data["token"];

      await CacheHelper.saveToken(token!);

      print("TOKEN: $token");

      if (data["student"] != null) {
        return Student.fromJson(data["student"]);
      }

      if (data["user"] != null) {
        final user = UserModel.fromJson(data["user"]);

        return user;
      }
    } else {
      throw Exception(data["message"] ?? "Login failed");
    }
  }
}
