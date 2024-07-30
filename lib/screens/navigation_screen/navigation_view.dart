import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/screens/home_screen/home_view.dart';
import 'package:frontend/screens/profile_screen/profile_screen.dart';
import 'package:frontend/screens/qr_code_screen/qrcode_screen.dart';
import 'package:frontend/screens/recommended_screen/recommend_products.dart';
import 'package:frontend/screens/scan_screen/scan_view.dart';
import 'package:frontend/screens/shopping_cart_screen/shoping_cart_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  late int _selectedIndex;

  static const List<Widget> _screens = [
    HomeView(),
    QRCodeScreen(),
    ScanView(),
    ShopingCartView(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: AppColor.primary,
        color: AppColor.primary,
        animationDuration: const Duration(milliseconds: 399),
        items: const <Widget>[
          Icon(Icons.home, size: 26, color: Colors.white),
          Icon(Icons.exit_to_app, size: 26, color: Colors.white),
          Icon(Icons.qr_code_scanner_outlined, size: 26, color: Colors.white),
          Icon(Icons.shopping_cart, size: 26, color: Colors.white),
          Icon(Icons.person, size: 26, color: Colors.white),
        ],
        onTap: _onItemTapped,
        index: _selectedIndex,
      ),
    );
  }
}
