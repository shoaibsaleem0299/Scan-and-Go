import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          "Favorite",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(4),
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
                child: ListTile(
                  leading: Image.network(
                    "",
                    errorBuilder: (context, error, stackTrace) {
                      // If the network image fails to load, display an asset image instead
                      return Image.asset(
                        'assets/images/app_image.png',

                        // You can also provide additional properties here if needed
                      );
                    },
                  ),
                  title: const Text(
                    "Favorite",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("category"),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_circle_outline_outlined)),
                ),
              );
            }),
      ),
    );
  }
}
