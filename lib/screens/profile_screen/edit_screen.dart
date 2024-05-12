import 'package:flutter/material.dart';
import 'package:frontend/screens/profile_screen/widget/custom_product_tile.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomProfileTile(
              title: "Name",
              prefixIcon: "person",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
