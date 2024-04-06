import 'package:flutter/material.dart';

class UserInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String prefixIcon;
  final String suffixIcon;
  final TextEditingController? controller;
  const UserInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
    this.controller,
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
      // Add more mappings as needed
    };

    IconData prefixIconData = iconDataMap[widget.prefixIcon] ?? Icons.error;
    IconData suffixIconData = iconDataMap[widget.suffixIcon] ?? Icons.error;

    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 237, 237, 237),
        prefixIcon: Icon(prefixIconData),
        suffixIcon: IconButton(onPressed: () {}, icon: Icon(suffixIconData)),
      ),
    );
  }
}
