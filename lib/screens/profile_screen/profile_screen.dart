import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/screens/login_screen/login.dart';
import 'package:frontend/screens/profile_screen/edit_screen.dart';
import 'package:frontend/screens/profile_screen/help_screen.dart';
import 'package:frontend/screens/profile_screen/history_screen.dart';
import 'package:frontend/screens/profile_screen/payment_screen.dart';
import 'package:frontend/screens/profile_screen/widget/custom_product_tile.dart';
import 'package:frontend/screens/splash_screen/splash_view.dart';
import 'package:frontend/widgets/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppColor.primary,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.black,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 2),
                      child: Text(
                        "User Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    const Text(
                      "User Email",
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
                              builder: (context) => HistoryScreen()),
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
                    AppButton(
                        buttonText: "Sign Out",
                        onButtonTap: () async {
                          var sharePref = await SharedPreferences.getInstance();
                          sharePref.setString(
                              SplashScreenState.loggedInKey, "");

                          Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const LogIn()),
                            ),
                          );
                        }),
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
