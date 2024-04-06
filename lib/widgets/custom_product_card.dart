import 'package:flutter/material.dart';

class CustomProductCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageUrl;
  final String price;
  final String status;
  final VoidCallback onTap;
  const CustomProductCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.onTap,
    required this.subTitle,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 160,
            height: 200,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color.fromARGB(255, 250, 248, 248),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2), // Shadow color
                  spreadRadius: 5, // Spread radius
                  blurRadius: 7, // Blur radius
                  offset: Offset(0, 3), // Offset from the top-left corner
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Text(
                        status,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Image.network(
                    imageUrl,
                    width: 90, // Adjust width as needed
                    height: 60, // Adjust height as needed
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 16,
                          ),
                        ),
                        // Text(
                        //   subTitle,
                        //   style: const TextStyle(
                        //     fontWeight: FontWeight.w200,
                        //     letterSpacing: 1,
                        //   ),
                        // ),
                      ],
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
