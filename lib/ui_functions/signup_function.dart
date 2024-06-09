// import 'package:flutter/material.dart';
// import 'package:frontend/constants/app_colors.dart';
// import 'package:frontend/constants/app_urls.dart';
// import 'package:frontend/screens/login_screen/login.dart';
// import 'package:dio/dio.dart';

// class SignupFunction {
//   static Future<void> registerUser(
//     BuildContext context,
//     TextEditingController emailController,
//     TextEditingController passwordController,
//     TextEditingController nameController,
//     TextEditingController usernameController,
//     TextEditingController confirmPasswordController,
//   ) async {
//     var url = '${AppURL.BaseURL}/api/register';

//     try {
//       final dio = Dio();
//       final response = await dio.post(
//         url,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//         ),
//         data: {
//           'name': nameController.text,
//           'username': usernameController.text,
//           'email': emailController.text,
//           'password': passwordController.text,
//           'confirm_password': confirmPasswordController.text,
//         },
//       );
//       if (response.statusCode == 200) {
//         // ignore: use_build_context_synchronously
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             backgroundColor: AppColor.primary,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             content: const Center(
//               child: Text(
//                 "Registration Successful",
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//             duration: const Duration(seconds: 2),
//           ),
//         );
//         Navigator.pushReplacement(
//           // ignore: use_build_context_synchronously
//           context,
//           MaterialPageRoute(
//             builder: (context) => const LogIn(),
//           ),
//         );
//       } else {
//         var responseBody = response.data;
//         // ignore: use_build_context_synchronously
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             backgroundColor: AppColor.primary,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             content: Center(
//               child: Text(
//                 responseBody['errors'].toString(),
//                 style: const TextStyle(
//                     color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: AppColor.primary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           content: Center(
//             child: Text(
//               'An error occurred: $e',
//               style: const TextStyle(
//                   color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }
// }

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
      print('Error: $e');
      return {'status': 'error', 'message': 'An error occurred: $e'};
    }
  }
}
