import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class Product {
  final String productName;
  final String category;
  final String imageUrl;
  final String price;
  final String status;
  final String description;

  Product({
    required this.productName,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.status,
    required this.description,
  });
}

List<Product> favorites = [];

class CustomProductCard extends StatefulWidget {
  final String productName;
  final String category;
  final String imageUrl;
  final String price;
  final String status;
  final String description;
  final VoidCallback onTap;
  final Function(Product) onAddToFavorites;

  const CustomProductCard({
    super.key,
    required this.productName,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.status,
    required this.onTap,
    required this.description,
    required this.onAddToFavorites,
  });

  @override
  State<CustomProductCard> createState() => _CustomProductCardState();
}

class _CustomProductCardState extends State<CustomProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(255, 250, 248, 248),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.status,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                            if (isFavorite) {
                              widget.onAddToFavorites(Product(
                                productName: widget.productName,
                                category: widget.category,
                                price: widget.price,
                                imageUrl: widget.imageUrl,
                                status: widget.status,
                                description: widget.description,
                              ));
                            } else {
                              // Remove from favorites if already added
                              // Implement if necessary
                            }
                          });
                        },
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: Image.network(
                        widget.imageUrl,
                        width: 55,
                        errorBuilder: (context, error, stackTrace) {
                          // If the network image fails to load, display an asset image instead
                          return Image.asset(
                            'assets/images/app_image.png',
                            width: 65,
                            // You can also provide additional properties here if needed
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              widget.category,
                              style: const TextStyle(
                                fontWeight: FontWeight.w200,
                                letterSpacing: 1,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Rs. ${widget.price}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
