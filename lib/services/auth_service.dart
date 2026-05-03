import 'dart:convert';
import '../core/logic/api_service.dart';
import '../views/model/user_model.dart';


class AuthService {

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final response = await ApiService.register(
      name: name,
      email: email,
      password: password,
      role: role,
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return UserModel.fromJson(data["user"]);
    } else {
      throw Exception(data["message"] ?? "Register failed");
    }
  }



  static Future<UserModel> login({
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
      return UserModel.fromJson(data["user"]);
    } else {
      throw Exception(data["message"] ?? "Login failed");
    }
  }

}