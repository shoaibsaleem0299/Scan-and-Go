import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/screens/guard_profile_screen/guard_view.dart';
import 'package:frontend/screens/login_screen/login.dart';
import 'package:frontend/screens/navigation_screen/navigation_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    whereToGo();
  }

  static const String loggedInKey = "Login";
  static const String loggedInRole = "Role";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: const Center(
        child: Text(
          "Scan and Go",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedInString = sharedPref.getString(loggedInKey);
    var isLoggedInRole = sharedPref.getInt(loggedInRole);
    var isLoggedIn =
        isLoggedInString != null ? isLoggedInString == 'true' : null;

    await Future.delayed(const Duration(milliseconds: 500), () {});
    if (isLoggedIn != null) {
      if (isLoggedIn) {
        if (isLoggedInRole == 3) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const NavigationView()));
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const GuardView()));
        }
      } else {
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const LogIn()));
      }
    } else {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const LogIn()));
    }
  }
}
