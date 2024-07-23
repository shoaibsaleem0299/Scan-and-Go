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
import 'package:frontend/screens/guard_profile_screen/guard_view.dart';
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
      if (response.data['status'] == 'success') {
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString(SplashScreenState.loggedInKey, true.toString());
        var responseBody = response.data;

        String token = responseBody['data']['token'];
        sharedPref.setString(ProfileViewState.tokenKey, token);

        int role = responseBody["data"]["role"]["id"];
        sharedPref.setInt(SplashScreenState.loggedInRole, role);

        String userName = responseBody['data']['name'];
        sharedPref.setString(UserData.NAMEKEY, userName);
        String userEmail = responseBody['data']['email'];
        sharedPref.setString(UserData.EMAILKEY, userEmail);

        if (response.data["data"]["role"]["name"] == "Customer") {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationView(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const GuardView(),
            ),
          );
        }
      } else {
        var responseBody = response.data;
        String errorMessage =
            responseBody['message'] ?? 'Unknown error occurred';
        setErrorMessage(errorMessage);
      }
    } catch (e) {
      setErrorMessage("Credentials Not Matched!");
      emailController.clear();
      passwordController.clear();
    }
  }
}


// import 'package:flutter/material.dart';
// import 'package:frontend/constants/api_constant.dart';
// import 'package:frontend/constants/app_urls.dart';
// import 'package:frontend/screens/navigation_screen/navigation_view.dart';
// import 'package:frontend/screens/profile_screen/profile_view.dart';
// import 'package:frontend/screens/splash_screen/splash_view.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginFunction {
//   static Future<void> signIn(
//     BuildContext context,
//     TextEditingController emailController,
//     TextEditingController passwordController,
//     GlobalKey<FormState> formKey,
//     Function(String) setErrorMessage,
//   ) async {
//     if (!formKey.currentState!.validate()) {
//       return;
//     }

//     var url = '${AppURL.BaseURL}/api/login';
//     try {
//       final dio = Dio(BaseOptions(
//         baseUrl: AppURL.BaseURL,
//         connectTimeout: const Duration(seconds: 5), // 5 seconds
//         receiveTimeout: const Duration(seconds: 3), // 3 seconds
//       ));
//       final response = await dio.post(
//         url,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//         ),
//         data: {
//           'email': emailController.text,
//           'password': passwordController.text,
//         },
//       );

//       if (response.statusCode == 200) {
//         var sharedPref = await SharedPreferences.getInstance();
//         sharedPref.setString(SplashScreenState.loggedInKey, true.toString());
//         var responseBody = response.data;
//         String token = responseBody['data']['token'];
//         sharedPref.setString(ProfileViewState.tokenKey, token);
//         String userName = responseBody['data']['name'];
//         sharedPref.setString(UserData.NAMEKEY, userName);
//         String userEmail = responseBody['data']['email'];
//         sharedPref.setString(UserData.EMAILKEY, userEmail);

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const NavigationView(),
//           ),
//         );
//       } else {
//         var responseBody = response.data;
//         String errorMessage =
//             responseBody['message'] ?? 'Unknown error occurred';
//         setErrorMessage(errorMessage);
//       }
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionTimeout) {
//         setErrorMessage('Connection timeout. Please try again.');
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         setErrorMessage('Receive timeout. Please try again.');
//       } else if (e.type == DioExceptionType.badResponse) {
//         setErrorMessage('Bad response: ${e.message}');
//       } else {
//         setErrorMessage('Unknown error occurred: ${e.message}');
//       }
//       emailController.clear();
//       passwordController.clear();
//     } catch (e) {
//       print(e);
//       setErrorMessage('Unknown error occurred: $e');
//       emailController.clear();
//       passwordController.clear();
//     }
//   }
// }
