import 'package:flutter/material.dart';
import 'package:frontend/screens/shopping_cart_screen/widget/custom_cart_item.dart';

class ShopingCartView extends StatefulWidget {
  const ShopingCartView({super.key});

  @override
  State<ShopingCartView> createState() => _ShopingCartViewState();
}

class _ShopingCartViewState extends State<ShopingCartView> {
  @override
  Widget build(BuildContext context) {
    List products = [
      {
        'imageUrl':
            "https://www.bookmymango.in/wp-content/uploads/2021/04/gir-kesar.png",
        'title': "mango",
        'subtitle': "fruit",
        'price': 12.0
      },
      {
        'imageUrl':
            "https://www.bookmymango.in/wp-content/uploads/2021/04/gir-kesar.png",
        'title': "mango",
        'subtitle': "fruit",
        'price': 12.0
      },
    ];
    void removeItem(index) {
      setState(() {
        products.removeAt(index);
      });
    }

    // double calculateTotalPrice() {
    //   double totalPrice = 0.0;
    //   for (var product in products) {
    //     totalPrice += product['price'] * qua;
    //   }
    //   return totalPrice;
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 4,
            child: ListView.builder(
              key: UniqueKey(),
              itemCount: products.length,
              itemBuilder: ((context, index) {
                return CustomCartItem(
                  key: UniqueKey(),
                  imageUrl: products[index]['imageUrl'],
                  title: products[index]['title'],
                  subtitle: products[index]['subtitle'],
                  price: products[index]['price'],
                  removeItem: () {
                    removeItem(index);
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
              flex: 2,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Sub Total : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        ),
                        Text(
                          "Rs. 123.09",
                          // "Rs.  ${calculateTotalPrice().toStringAsFixed(2)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      )),
    );
  }
}
