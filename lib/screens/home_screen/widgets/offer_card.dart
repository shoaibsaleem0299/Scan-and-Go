import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class OfferCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageUrl;
  final VoidCallback onTap;

  const OfferCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.onTap,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColor.primary,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Shadow color
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: const Offset(0, 3), // Offset from the top-left corner
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Image.network(
                imageUrl,
                width: 140, // Adjust width as needed
                height: 140, // Adjust height as needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}
