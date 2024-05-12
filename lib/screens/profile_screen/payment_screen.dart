import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("payment Screen"),
    );
  }
}

// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:frontend/screens/product_screen/cart_product_screen.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfileView extends StatefulWidget {
//   const ProfileView({Key? key}) : super(key: key);

//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   List<Map<String, dynamic>> users = [];
//   List<Map<String, dynamic>> productCart = [];
//   List<Map<String, dynamic>> allCartProducts = [];
//   TextEditingController userId = TextEditingController();

//   static const String tokenKey = "Login";

//   Future<String?> userToken() async {
//     var sharedPref = await SharedPreferences.getInstance();
//     var user_token = sharedPref.getString(tokenKey);
//     return user_token;
//   }

//   Future<void> getDummyUser() async {
//     String? token = await userToken();
//     if (token != null) {
//       var url =
//           Uri.parse("http://127.0.0.1:8000/api/product/barcode/${userId.text}");
//       try {
//         var response = await http.get(url, headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $token', // Use the retrieved token here
//         });
//         if (response.statusCode == 200) {
//           var responseBody = jsonDecode(response.body);
//           setState(() {
//             users.add(responseBody);
//           });
//         } else {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: const Text('Error'),
//                 content: Text(
//                     'Failed to get user. Status code: ${response.statusCode}'),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text('OK'),
//                   ),
//                 ],
//               );
//             },
//           );
//           print("Failed to get user. Status code: ${response.statusCode}");
//         }
//       } catch (e) {
//         print("Error occurred: $e");
//       }
//     } else {
//       // Handle case where token is null
//     }
//   }

//   // Remaining code...
// }
