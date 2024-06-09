import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/screens/navigation_screen/navigation_view.dart';
import 'package:frontend/widgets/app_button.dart';
import 'package:frontend/widgets/item_counter.dart';

class CartProductView extends StatelessWidget {
  final int? productId;
  final String name;
  final String category;
  final String initialPrice;
  final int initialQuantity;
  final String imageUrl;
  final String description;
  final String location;
  final int? status;
  final Function(Map<String, dynamic>) onAddToCart;

  const CartProductView({
    super.key,
    required this.name,
    required this.category,
    required this.initialPrice,
    required this.initialQuantity,
    required this.description,
    required this.location,
    required this.status,
    required this.imageUrl,
    required this.onAddToCart,
    required this.productId,
  });

  String? statusUpdate(int status) {
    if (status > 5) {
      return "In stock";
    } else if (status > 0 && status <= 5) {
      return "In stock: $status left";
    } else {
      return "Out of stock";
    }
  }

  @override
  Widget build(BuildContext context) {
    double productPrice = double.parse(initialPrice);
    int updatedQuantity = initialQuantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: AppColor.primary,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Center(
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Image.asset(
                          'assets/images/app_image.png',
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                category,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Status: ${statusUpdate(status!)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Location: $location",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Price",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              ItemCounter(
                initialValue: initialQuantity,
                pricePerItem: productPrice,
                onChanged: (newQuantity) {
                  updatedQuantity = newQuantity;
                },
              ),
              const SizedBox(height: 10),
              AppButton(
                buttonText: "Add To Cart",
                onButtonTap: () {
                  onAddToCart(
                    {
                      'productId': productId,
                      'name': name,
                      'category': category,
                      'price': productPrice * updatedQuantity,
                      'quantity': updatedQuantity,
                    },
                  );
                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const NavigationView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
