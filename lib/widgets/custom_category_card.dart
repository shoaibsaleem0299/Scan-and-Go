import 'package:flutter/material.dart';

class CustomCategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  const CustomCategoryCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.all(6.0),
            // margin: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(255, 250, 248, 248),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.06), // Shadow color
                  spreadRadius: 5, // Spread radius
                  blurRadius: 7, // Blur radius
                  offset: const Offset(0, 3), // Offset from the top-left corner
                ),
              ],
            ),
            child: Image.network(
              imageUrl,
              width: 40,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
