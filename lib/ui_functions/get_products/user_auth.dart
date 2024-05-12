// user_auth.dart

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserAuth {
  static const String tokenKey = "Login";

  static Future<String?> userToken() async {
    var sharedPref = await SharedPreferences.getInstance();
    var user_token = sharedPref.getString(tokenKey);
    return user_token;
  }

  static Future<void> getDummyUser(
      BuildContext context, TextEditingController userIdController) async {
    String? token = await userToken();
    if (token != null) {
      var url = Uri.parse(
          "http://127.0.0.1:8000/api/product/barcode/${userIdController.text}");
      try {
        var response = await http.get(url, headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Use the retrieved token here
        });
        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          // Handle the response data accordingly
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(
                    'Failed to get user. Status code: ${response.statusCode}'),
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
          print("Failed to get user. Status code: ${response.statusCode}");
        }
      } catch (e) {
        print("Error occurred: $e");
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Unauthorized Access'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogIn(),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
