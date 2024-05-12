// login_function.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/navigation_screen/navigation_view.dart';
import 'package:frontend/screens/profile_screen/profile_view.dart';
import 'package:frontend/screens/splash_screen/splash_view.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFunction {
  static Future<void> signIn(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) async {
    const url = 'http://127.0.0.1:8000/api/login/';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString(SplashScreenState.loggedInKey, true.toString());
        var responseBody = jsonDecode(response.body);
        String token = responseBody['data']['token'];
        sharedPref.setString(ProfileViewState.tokenKey, token);

        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const NavigationView(),
          ),
        );
      }
    } on ClientException {
      emailController.clear();
      passwordController.clear();
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Invalid email or password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error: $e');
    }
  }
}
