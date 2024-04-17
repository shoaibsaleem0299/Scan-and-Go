import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class HeadingTile extends StatelessWidget {
  final String title;
  final void Function()? goTO;
  const HeadingTile({super.key, required this.title, this.goTO});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
