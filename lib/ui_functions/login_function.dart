// // login_function.dart

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:frontend/constants/app_colors.dart';
// import 'package:frontend/screens/navigation_screen/navigation_view.dart';
// import 'package:frontend/screens/profile_screen/profile_view.dart';
// import 'package:frontend/screens/splash_screen/splash_view.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginFunction {
//   static Future<void> signIn(
//       BuildContext context,
//       TextEditingController emailController,
//       TextEditingController passwordController) async {
//     const url = 'http://127.0.0.1:8000/api/login/';
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode({
//           'email': emailController.text,
//           'password': passwordController.text,
//         }),
//       );

//       if (response.statusCode == 200) {
//         var sharedPref = await SharedPreferences.getInstance();
//         sharedPref.setString(SplashScreenState.loggedInKey, true.toString());
//         var responseBody = jsonDecode(response.body);
//         String token = responseBody['data']['token'];
//         sharedPref.setString(ProfileViewState.tokenKey, token);

//         Navigator.pushReplacement(
//           // ignore: use_build_context_synchronously
//           context,
//           MaterialPageRoute(
//             builder: (context) => const NavigationView(),
//           ),
//         );
//       }
//     } on ClientException {
//       emailController.clear();
//       passwordController.clear();
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: AppColor.primary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           content: const Center(
//             child: Text(
//               "Incorrect credentials",
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontend/constants/api_constant.dart';
import 'package:frontend/constants/app_urls.dart';
import 'package:frontend/screens/navigation_screen/navigation_view.dart';
import 'package:frontend/screens/profile_screen/profile_view.dart';
import 'package:frontend/screens/splash_screen/splash_view.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFunction {
  static Future<void> signIn(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      GlobalKey<FormState> formKey,
      Function(String) setErrorMessage) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    var url = '${AppURL.BaseURL}/api/login';
    try {
      final dio = Dio();
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString(SplashScreenState.loggedInKey, true.toString());
        var responseBody = response.data;
        String token = responseBody['data']['token'];
        sharedPref.setString(ProfileViewState.tokenKey, token);
        String userName = responseBody['data']['name'];
        sharedPref.setString(UserData.NAMEKEY, userName);
        String userEmail = responseBody['data']['email'];
        sharedPref.setString(UserData.EMAILKEY, userEmail);

        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const NavigationView(),
          ),
        );
      } else {
        var responseBody = response.data;
        String errorMessage =
            responseBody['message'] ?? 'Unknown error occurred';
        setErrorMessage(errorMessage);
      }
      // ignore: deprecated_member_use
    } on DioError {
      setErrorMessage("Unknown error occurred");
      emailController.clear();
      passwordController.clear();
    }
  }
}
