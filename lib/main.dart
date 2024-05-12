import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen/login.dart';
import 'package:frontend/screens/navigation_screen/navigation_view.dart';
import 'package:frontend/screens/profile_screen/profile_screen.dart';
import 'package:frontend/screens/profile_screen/profile_view.dart';
import 'package:frontend/screens/signup_screen/sign_up.dart';
import 'package:frontend/screens/splash_screen/splash.dart';

void main(List<String> args) {
  runApp(const ScanAndGO());
}

class ScanAndGO extends StatelessWidget {
  const ScanAndGO({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Scan And Go",
      home: SplashScreen(),
      // home: NavigationView(),
      // home: ProfileView(),
      // home: ProfileScreen(),
    );
  }
}
