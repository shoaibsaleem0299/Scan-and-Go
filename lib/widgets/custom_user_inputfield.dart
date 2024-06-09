import 'package:flutter/material.dart';

class UserInputField extends StatefulWidget {
  final String labelText;
  final String prefixIcon;
  final String nullText;
  final bool boolText;

  final TextEditingController? controller;
  const UserInputField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    this.controller,
    required this.nullText,
    required this.boolText,
  });

  @override
  State<UserInputField> createState() => _UserInputFieldState();
}

class _UserInputFieldState extends State<UserInputField> {
  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> iconDataMap = {
      'account_circle': Icons.account_circle,
      'search': Icons.search,
      'microphone': Icons.mic_rounded,
      'person': Icons.person,
      'payment': Icons.payments_outlined,
      'history': Icons.history,
      'help': Icons.help_outline,
      'receipts': Icons.receipt_long,
      'email': Icons.email_outlined,
      'password': Icons.remove_red_eye_outlined,
      // Add more mappings as needed
    };

    IconData prefixIconData = iconDataMap[widget.prefixIcon] ?? Icons.error;
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.boolText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your ${widget.nullText}';
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal: 20.0,
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 237, 237, 237),
        prefixIcon: Icon(prefixIconData),
      ),
    );
  }
}
