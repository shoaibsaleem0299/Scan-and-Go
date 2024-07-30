import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final void Function() onButtonTap;
  const AppButton(
      {super.key,
      required this.buttonText,
      required this.onButtonTap,
      bool? isDisabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 6,
      height: 35,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(AppColor.primary),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
        ),
        onPressed: onButtonTap,
        child: Text(
          buttonText,
          style: TextStyle(
            color: AppColor.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
