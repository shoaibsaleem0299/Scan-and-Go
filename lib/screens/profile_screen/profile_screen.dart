import 'package:flutter/material.dart';
import 'package:frontend/screens/profile_screen/edit_screen.dart';
import 'package:frontend/screens/profile_screen/help_screen.dart';
import 'package:frontend/screens/profile_screen/history_screen.dart';
import 'package:frontend/screens/profile_screen/payment_screen.dart';
import 'package:frontend/screens/profile_screen/receipts.screen.dart';
import 'package:frontend/screens/profile_screen/widget/custom_product_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.black,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add_a_photo),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 2),
                      child: Text(
                        "Shoaib Saleem",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    const Text(
                      "shoaib0299@gmail.com",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, letterSpacing: 1),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    CustomProfileTile(
                      title: "Edit Profile",
                      prefixIcon: "person",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditScreen()),
                        );
                      },
                    ),
                    CustomProfileTile(
                      title: "Payment Method",
                      prefixIcon: "payment",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentScreen()),
                        );
                      },
                    ),
                    CustomProfileTile(
                      title: "History",
                      prefixIcon: "history",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HistoryScreen()),
                        );
                      },
                    ),
                    CustomProfileTile(
                      title: "Receipts",
                      prefixIcon: "receipts",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReceiptsScreen()),
                        );
                      },
                    ),
                    CustomProfileTile(
                      title: "Help Center",
                      prefixIcon: "help",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("copyright @ 2024 - Scan and Go"),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
