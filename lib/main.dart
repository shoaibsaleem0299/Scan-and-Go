import 'package:flutter/material.dart';
import 'package:frontend/screens/navigation_screen/navigation_view.dart';

void main(List<String> args) {
  runApp(const ScanAndGO());
}

class ScanAndGO extends StatelessWidget {
  const ScanAndGO({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Scan And Go",
      home: NavigationView(),
    );
  }
}
