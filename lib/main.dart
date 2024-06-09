import 'package:flutter/material.dart';
import 'package:frontend/screens/splash_screen/splash_view.dart';

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
    );
  }
}
