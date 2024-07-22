// import 'package:flutter/material.dart';
// import 'package:frontend/constants/app_colors.dart';
// import 'package:frontend/screens/login_screen/login.dart';
// import 'package:frontend/widgets/app_button.dart';
// import 'package:frontend/widgets/custom_user_inputfield.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SignupScreenState createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   String _errorMessage = '';

//   Future<void> _signup() async {
//     if (_formKey.currentState!.validate()) {
//       final response = await http.post(
//         Uri.parse('http://127.0.0.1:8000/api/register'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'name': nameController.text,
//           'username': usernameController.text,
//           'email': emailController.text,
//           'password': passwordController.text,
//           'confirm_password': confirmPasswordController.text,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseBody = json.decode(response.body);
//         if (responseBody['status'] == 'success') {
//           // Navigate to login screen
//           Navigator.pushReplacement(
//               // ignore: use_build_context_synchronously
//               context,
//               MaterialPageRoute(builder: (context) => const LogIn()));
//           // Navigator.pushReplacementNamed(context, '/login');
//         } else {
//           setState(() {
//             _errorMessage = responseBody['message'] ?? 'Unknown error occurred';
//           });
//         }
//       } else {
//         setState(() {
//           _errorMessage = 'Failed to sign up. Please try again.';
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           "SignUp",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: AppColor.primary,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const SizedBox(
//                 height: 120.0,
//                 width: 170.0,
//                 child: Text(
//                   'Create An Account',
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//               UserInputField(
//                 labelText: "Name",
//                 prefixIcon: "person",
//                 nullText: "Name",
//                 boolText: false,
//                 controller: nameController,
//               ),
//               const SizedBox(height: 8),
//               UserInputField(
//                 labelText: "Username",
//                 prefixIcon: "person",
//                 nullText: "Username",
//                 boolText: false,
//                 controller: usernameController,
//               ),
//               const SizedBox(height: 8),
//               UserInputField(
//                 labelText: "Email",
//                 prefixIcon: "email",
//                 nullText: "Email",
//                 boolText: false,
//                 controller: emailController,
//               ),
//               const SizedBox(height: 8),
//               UserInputField(
//                 labelText: "Password",
//                 prefixIcon: "password",
//                 nullText: "Password",
//                 boolText: true,
//                 controller: passwordController,
//               ),
//               const SizedBox(height: 8),
//               UserInputField(
//                 labelText: "Confirm Password",
//                 prefixIcon: "password",
//                 nullText: "Confirm Password",
//                 boolText: true,
//                 controller: confirmPasswordController,
//               ),
//               const SizedBox(height: 20),
//               AppButton(buttonText: "Register", onButtonTap: _signup),
//               const SizedBox(height: 20),
//               if (_errorMessage.isNotEmpty)
//                 Text(
//                   _errorMessage,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Already Have An Account?",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const LogIn(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       " Sign In",
//                       style: TextStyle(fontSize: 16, color: AppColor.primary),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/screens/login_screen/login.dart';
import 'package:frontend/ui_functions/signup_function.dart';
import 'package:frontend/widgets/app_button.dart';
import 'package:frontend/widgets/custom_user_inputfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String _errorMessage = '';

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        final result = await SignupService.registerUser(
          nameController.text,
          usernameController.text,
          emailController.text,
          passwordController.text,
          confirmPasswordController.text,
        );

        if (result['status'] == 'success') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              content: const Center(
                child: Text(
                  "Registration Successful",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const LogIn(),
            ),
          );
        } else {
          setState(() {
            _errorMessage =
                result['message'] ?? 'Failed to sign up. Please try again.';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage =
              'An unexpected error occurred. Please try again later.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "SignUp",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColor.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 60,
                ),
                const SizedBox(
                  height: 150.0,
                  width: 178.0,
                  child: Text(
                    'Create An Account',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
                  ),
                ),
                UserInputField(
                  labelText: "Name",
                  prefixIcon: "person",
                  nullText: "Name",
                  boolText: false,
                  controller: nameController,
                ),
                const SizedBox(height: 12),
                UserInputField(
                  labelText: "Username",
                  prefixIcon: "person",
                  nullText: "Username",
                  boolText: false,
                  controller: usernameController,
                ),
                const SizedBox(height: 12),
                UserInputField(
                  labelText: "Email",
                  prefixIcon: "email",
                  nullText: "Email",
                  boolText: false,
                  controller: emailController,
                ),
                const SizedBox(height: 12),
                UserInputField(
                  labelText: "Password",
                  prefixIcon: "password",
                  nullText: "Password",
                  boolText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 12),
                UserInputField(
                  labelText: "Confirm Password",
                  prefixIcon: "password",
                  nullText: "Confirm Password",
                  boolText: true,
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 12),
                if (_errorMessage.isNotEmpty)
                  Center(
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 12),
                AppButton(buttonText: "Register", onButtonTap: _signup),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already Have An Account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogIn(),
                          ),
                        );
                      },
                      child: Text(
                        " Sign In",
                        style: TextStyle(fontSize: 16, color: AppColor.primary),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
