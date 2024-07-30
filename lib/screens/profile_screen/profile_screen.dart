import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/screens/home_screen/home_view.dart';
import 'package:frontend/screens/login_screen/login.dart';
import 'package:frontend/screens/profile_screen/edit_screen.dart';
import 'package:frontend/screens/profile_screen/help_screen.dart';
import 'package:frontend/screens/profile_screen/history_screen.dart';
import 'package:frontend/screens/profile_screen/payment_screen.dart';
import 'package:frontend/screens/profile_screen/widget/custom_product_tile.dart';
import 'package:frontend/screens/splash_screen/splash_view.dart';
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
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          "https://static.vecteezy.com/system/resources/thumbnails/005/545/335/small/user-sign-icon-person-symbol-human-avatar-isolated-on-white-backogrund-vector.jpg"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 2),
                      child: Text(
                        HomeViewState.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    Text(
                      HomeViewState.email,
                      style: const TextStyle(
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
                      title: "Order History",
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
                    IconButton(
                      onPressed: () async {
                        var sharePref = await SharedPreferences.getInstance();
                        sharePref.setString(SplashScreenState.loggedInKey, "");

                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const LogIn()),
                          ),
                        );
                      },
                      icon: const Icon(Icons.logout),
                      padding: const EdgeInsets.all(12.0),
                      color: Colors.white,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 188, 23, 23),
                        ),
                      ),
                    )
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
