import 'package:flutter/material.dart';
import 'package:frontend/screens/guard_profile_screen/guard_view.dart';
import 'package:frontend/screens/navigation_screen/navigation_view.dart';
import 'package:frontend/screens/splash_screen/splash_view.dart';

void main(List<String> args) {
  runApp(const ScanAndGO());
}

class ScanAndGO extends StatelessWidget {
  const ScanAndGO({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Scan And Go",
        // home: SplashScreen(),
        home: GuardView());
  }
}
