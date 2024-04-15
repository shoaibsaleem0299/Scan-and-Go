import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/product_screen/cart_product_screen.dart';
import 'package:http/http.dart' as http;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> productCart = [];
  List<Map<String, dynamic>> allCartProducts = [];
  TextEditingController userId = TextEditingController();

  Future<void> getDummyUser() async {
    var url =
        Uri.parse("https://jsonplaceholder.typicode.com/users/${userId.text}");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        setState(() {
          users.add(responseBody);
        });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: userId,
                decoration: const InputDecoration(
                  labelText: 'Enter User ID',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await getDummyUser();
                  userId.clear();
                  if (users.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartProductView(
                          imageUrl:
                              "https://www.sunsetgrown.com/wp-content/uploads/2020/10/XLBeef_StraightOn_001-1024x714.png",
                          name: "${users.last['name']}",
                          category: "${users.last['username']}",
                          initialPrice: 20.0,
                          initialQuantity: 1,
                          description:
                              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          location: "second",
                          status: "Available",
                          productId: "${users.last['id']}",
                          onAddToCart: (productData) {
                            setState(() {
                              allCartProducts.add(productData);
                            });
                            print('Product added to cart: $allCartProducts');
                            print(allCartProducts.length);
                          },
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Get User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
