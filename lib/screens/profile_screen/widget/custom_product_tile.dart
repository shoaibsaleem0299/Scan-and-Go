import 'package:flutter/material.dart';

class CustomProfileTile extends StatelessWidget {
  final String title;
  final String prefixIcon;
  final void Function() onTap;
  const CustomProfileTile(
      {super.key,
      required this.title,
      required this.prefixIcon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> iconDataMap = {
      'account_circle': Icons.account_circle,
      'person': Icons.person,
      'payment': Icons.payments_outlined,
      'history': Icons.history,
      'help': Icons.help_outline,
      'receipts': Icons.receipt_long,
      // Add more mappings as needed
    };

    IconData prefixIconData = iconDataMap[prefixIcon] ?? Icons.error;
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        tileColor: const Color.fromARGB(255, 236, 235, 235),
        leading: Icon(prefixIconData),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
