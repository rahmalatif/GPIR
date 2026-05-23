import 'dart:convert';

class ErrorHandler {
  static String getMessage(
    dynamic error,
  ) {
    final errorString = error.toString();

    try {
      final jsonStart = errorString.indexOf('{');

      if (jsonStart != -1) {
        final jsonPart = errorString.substring(jsonStart);

        final data = jsonDecode(jsonPart);

        if (data['message'] != null) {
          return data['message'];
        }
      }
    } catch (_) {}

    if (errorString.contains("SocketException")) {
      return "No internet connection";
    }

    if (errorString.contains("TimeoutException")) {
      return "Request timeout";
    }

    if (errorString.contains("401")) {
      return "Unauthorized";
    }

    if (errorString.contains("403")) {
      return "Access denied";
    }

    if (errorString.contains("404")) {
      return "Data not found";
    }

    if (errorString.contains("500")) {
      return "Server error";
    }
    if (errorString.contains(
        "Invalid college code or password")) {

      return "Invalid student ID or password";
    }
    if (errorString.contains(
        "Invalid email or password")) {

      return "Invalid email or password";
    }

    return "Something went wrong";
  }
}
