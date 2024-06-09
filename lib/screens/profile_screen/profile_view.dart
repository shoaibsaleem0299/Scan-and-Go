import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/app_urls.dart';
import 'package:frontend/screens/login_screen/login.dart';
import 'package:frontend/screens/navigation_screen/navigation_view.dart';
import 'package:frontend/screens/product_screen/cart_product_screen.dart';
import 'package:frontend/widgets/app_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> productCart = [];
  List<Map<String, dynamic>> allCartProducts = [];
  TextEditingController userId = TextEditingController();

  static const String tokenKey = "token";
  Future<void> addToCart(id, quantity) async {
    String? token = await userToken();
    const url = "http://127.0.0.1:8000/api/cart/add_to_cart";
    try {
      await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'product_id': id,
          'quantity': quantity,
        }),
      );
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  Future<String?> userToken() async {
    var sharedPref = await SharedPreferences.getInstance();
    String? user_token = sharedPref.getString(tokenKey);
    return user_token;
  }

  Future<void> getDummyUser() async {
    String? token = await userToken();
    if (token != null) {
      var url = "${AppURL.BaseURL}/api/product/barcode/${userId.text}";
      try {
        var response = await Dio().get(
          url,
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
          ),
        );
        if (response.statusCode == 200) {
          var responseBody = response.data;
          setState(() {
            users.add(responseBody);
          });
        } else {
          showDialog(
            // ignore: use_build_context_synchronously
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
        // ignore: use_build_context_synchronously
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: userId,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 20.0,
                    ),
                    labelText: "Enter Product ID",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 237, 237, 237),
                    prefixIcon:
                        const Icon(Icons.production_quantity_limits_rounded),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                AppButton(
                  buttonText: "Get Product",
                  onButtonTap: () async {
                    await getDummyUser();
                    userId.clear();
                    if (users.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartProductView(
                            imageUrl:
                                "https://www.sunsetgrown.com/wp-content/uploads/2020/10/XLBeef_traightOn_001-1024x714.png",
                            name: "${users.last['name']}",
                            category: "${users.last['username']}",
                            initialPrice: "12.90",
                            initialQuantity: 1,
                            description: "${users.last['description']}",
                            location: "second",
                            status: 1,
                            productId: 1,
                            onAddToCart: (productData) {
                              addToCart(productData['productId'],
                                  productData['quantity']);
                              print("quantity : ${productData['quantity']}");
                              print("id : ${productData['productId']}");
                              setState(() {
                                allCartProducts.add(productData);
                              });
                              print('Product added to cart: $allCartProducts');
                              print(allCartProducts.length);
                            },
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('No Product Available For this ID'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NavigationView()));
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
