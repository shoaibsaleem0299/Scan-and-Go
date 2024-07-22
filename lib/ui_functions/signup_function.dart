import 'package:dio/dio.dart';
import 'package:frontend/constants/app_urls.dart';

class SignupService {
  static Future<Map<String, dynamic>> registerUser(
    String name,
    String username,
    String email,
    String password,
    String confirmPassword,
  ) async {
    var url = '${AppURL.BaseURL}/api/register';
    var message = "message";
    if (password != confirmPassword) {
      message = "Passwords not matched";
    } else {
      message = "Please use valid email";
    }
    final dio = Dio();
    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: {
          'name': name,
          'username': username,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        return {'status': 'success', 'data': response.data};
      } else {
        return {
          'status': 'error',
          'message': response.data['message'] ?? 'Unknown error occurred'
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Failed to sign up. $message',
      };
    }
  }
}
