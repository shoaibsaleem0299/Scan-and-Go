import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/screens/check_out_screen/checkout.dart';
import 'package:frontend/screens/profile_screen/profile_view.dart';
import 'package:frontend/screens/shopping_cart_screen/widget/custom_cart_item.dart';
import 'package:frontend/widgets/app_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShopingCartView extends StatefulWidget {
  const ShopingCartView({Key? key}) : super(key: key);

  @override
  State<ShopingCartView> createState() => _ShopingCartViewState();
}

class _ShopingCartViewState extends State<ShopingCartView> {
  late Future<List<Map<String, dynamic>>> _userProductCartFuture;

  @override
  void initState() {
    super.initState();
    _userProductCartFuture = getUserCart();
  }

  Future<List<Map<String, dynamic>>> getUserCart() async {
    String? token = await userToken();
    var url = Uri.parse("http://127.0.0.1:8000/api/cart/cart_by_user");
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('data') &&
            responseBody['data'] is Map &&
            responseBody['data'].containsKey('products') &&
            responseBody['data']['products'] is List) {
          // Extract the list of products from the response
          var products = responseBody['data']['products'];
          return List<Map<String, dynamic>>.from(products);
        } else {
          print("Invalid response format: $responseBody");
          return [];
        }
      } else {
        print("Failed to get user. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _userProductCartFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("Empty Cart"));
            } else {
              List<Map<String, dynamic>> userProductCart = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: ListView.builder(
                      itemCount: userProductCart.length,
                      itemBuilder: ((context, index) {
                        return CustomCartItem(
                          imageUrl: userProductCart[index]['imageUrl'] ?? "",
                          title: userProductCart[index]['name'] ?? "",
                          subtitle: userProductCart[index]['imageUrl'] ?? "",
                          price: userProductCart[index]['sale_price'] ?? "",
                          removeItem: () {
                            setState(() {
                              userProductCart.removeAt(index);
                            });
                          },
                        );
                      }),
                    ),
                  ),
                  const Divider(
                    color: Colors.black45,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Sub Total : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                              const Spacer(),
                              Text(
                                "Rs. 123.09",
                                // "Rs.  ${calculateTotalPrice().toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primary,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          AppButton(
                            buttonText: "Check Out",
                            onButtonTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<String?> userToken() async {
    var sharedPref = await SharedPreferences.getInstance();
    String? user_token = sharedPref.getString(ProfileViewState.tokenKey);
    return user_token;
  }
}
