import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/constants/app_urls.dart';
import 'package:frontend/models/user_cart.dart';
import 'package:frontend/screens/check_out_screen/checkout.dart';
import 'package:frontend/screens/profile_screen/profile_view.dart';
import 'package:frontend/screens/shopping_cart_screen/widget/custom_cart_item.dart';
import 'package:frontend/widgets/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopingCartView extends StatefulWidget {
  const ShopingCartView({super.key});

  @override
  State<ShopingCartView> createState() => _ShopingCartViewState();
}

class _ShopingCartViewState extends State<ShopingCartView> {
  late Future<UserCart> _userCartFuture;
  double grandTotal = 0.0;
  bool isCartEmpty = false;

  @override
  void initState() {
    super.initState();
    _userCartFuture = getUserCart();
  }

  Future<UserCart> getUserCart() async {
    String? token = await userToken();
    final url = "${AppURL.BaseURL}/api/cart/cart_by_user";
    final dio = Dio();

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        UserCart userCart = UserCart.fromJson(response.data);

        setState(() {
          grandTotal = calculateGrandTotal(userCart);
          isCartEmpty = userCart.data!.products!.isEmpty;
        });

        return userCart;
      } else {
        throw Exception(
            "Failed to get user cart. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw ("Empty Cart");
    }
  }

  double calculateGrandTotal(UserCart userCart) {
    double total = 0.0;
    for (var product in userCart.data!.products!) {
      total += double.parse(product.salePrice!) * product.pivot!.quantity!;
    }
    return total;
  }

  Future<void> removeItemFromCart(int productId, double productPrice) async {
    String? token = await userToken();
    final url = "${AppURL.BaseURL}/api/cart/remove_item/$productId";
    final dio = Dio();

    try {
      final response = await dio.delete(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          grandTotal -= productPrice;
          isCartEmpty = grandTotal <= 0;
        });
      } else {
        print(
            "Failed to remove item from cart. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred while removing item from cart: $e");
    }
  }

  void handleCheckout() {
    if (isCartEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Cart is Empty'),
            content: const Text(
                'Please add items to your cart before checking out.'),
            actions: <Widget>[
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
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CheckoutPage(),
        ),
      );
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
        backgroundColor: AppColor.primary,
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<UserCart>(
          future: _userCartFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              UserCart userCart = snapshot.data!;
              if (userCart.data!.products!.isEmpty) {
                return const Center(child: Text("Empty Cart"));
              }
              return Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: ListView.builder(
                      itemCount: userCart.data!.products!.length,
                      itemBuilder: ((context, index) {
                        Products product = userCart.data!.products![index];
                        return CustomCartItem(
                          imageUrl:
                              "${AppURL.BaseURL}/storage/${product.featureImage['path']}" ??
                                  "",
                          title: product.name ?? "",
                          price: product.salePrice ?? "",
                          quantity: product.pivot?.quantity ?? 0,
                          removeItem: () {
                            setState(() {
                              userCart.data!.products!.removeAt(index);
                              removeItemFromCart(
                                  product.id!,
                                  double.parse(product.salePrice!) *
                                      product.pivot!.quantity!);
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
                                "Rs. $grandTotal",
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
                            onButtonTap: handleCheckout,
                            isDisabled: isCartEmpty,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text("Empty Cart"));
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
