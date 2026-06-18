import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/logic/api_service.dart';
import '../core/logic/cache_helper.dart';
import '../views/model/student.dart';
import '../views/model/user_model.dart';

class AuthService {
  static UserModel? currentUser;
  static String? token;
  static String? email;
  static String? name;
  static int? studentId;
  static bool isLeader = false;
  static String? userId;
  static String? role;

  static Future<dynamic> register({
    required String name,
    required String password,
    required String role,
    String? email,
    int? id,
    required String phonenumber,
    String? specialization,
  }) async {
    final response = await ApiService.register(
        name: name,
        email: email,
        password: password,
        role: role,
        id: id,
        phonenumber: phonenumber,
        specialization: specialization);

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      if (role == "student") {
        return Student.fromJson(
          data["student"],
        );
      } else {
        return UserModel.fromJson(
          data["user"],
        );
      }
    } else {
      throw Exception(
        data["message"] ?? "Register failed",
      );
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

    print("LOGIN RESPONSE: $data");

    if (response.statusCode == 200) {
      token = data["token"];

      await CacheHelper.saveToken(
        token!,
      );

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        'token',
        token!,
      );

      if (data["student"] != null) {
        final student = Student.fromJson(
          data["student"],
        );

        AuthService.userId = student.id;
        AuthService.name = student.name;
        AuthService.role = "student";

        studentId = student.collegeCode;

        studentId = student.collegeCode;

        await prefs.setInt(
          'collegeCode',
          student.collegeCode,
        );

        await prefs.setString(
          'userId',
          student.id,
        );

        await prefs.setString(
          'role',
          'student',
        );
        await prefs.setString(
          'name',
          student.name,
        );

        print("SAVED COLLEGE CODE: ${student.collegeCode}");
        if (!kIsWeb) {
          final fcmToken = await FirebaseMessaging.instance.getToken();

          if (fcmToken != null) {
            await ApiService.saveFcmToken(fcmToken);
          }
        }

        return student;
      }

      if (data["user"] != null) {
        final user = UserModel.fromJson(data["user"]);

        AuthService.userId = user.id;
        AuthService.role = user.role;
        AuthService.email = user.email;
        AuthService.name = user.name;
        if (!kIsWeb) {
          final fcmToken = await FirebaseMessaging.instance.getToken();

          if (fcmToken != null) {
            await ApiService.saveFcmToken(fcmToken);
          }
        }
        await prefs.setString(
          'userId',
          user.id,
        );

        await prefs.setString(
          'role',
          user.role,
        );
        await prefs.setString(
          'name',
          user.name,
        );

        await prefs.setString(
          'email',
          user.email,
        );
        return user;
      }
    } else {
      throw Exception(
        data["message"] ?? "Login failed",
      );
    }
  }
  static Future<void> loadUserData() async {

    final prefs =
    await SharedPreferences.getInstance();

    token =
        prefs.getString('token');

    userId =
        prefs.getString('userId');

    role =
        prefs.getString('role');

    name =
        prefs.getString('name');

    email =
        prefs.getString('email');

    studentId =
        prefs.getInt('collegeCode');
  }
}

