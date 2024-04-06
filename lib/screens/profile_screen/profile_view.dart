import 'package:flutter/material.dart';
import 'package:frontend/widgets/custom_category_card.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: [
          CustomCategoryCard(title: "title", imageUrl: "", onTap: () {}),
          CustomCategoryCard(title: "title", imageUrl: "", onTap: () {}),
          CustomCategoryCard(title: "title", imageUrl: "", onTap: () {})
        ],
      ),
    );
  }
}
