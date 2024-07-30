import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  QRCodeScreenState createState() => QRCodeScreenState();
}

class QRCodeScreenState extends State<QRCodeScreen> {
  String _userId = "";
  static String userIdKey = "userd_i";

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  // Load user_id from local storage
  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(userIdKey).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "User QR Code",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppColor.primary,
      ),
      body: Center(
        child: _userId.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Scan this QR code",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20.0),
                  QrImageView(
                    data: _userId,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _loadUserId,
                    child: const Text("Refresh"),
                  ),
                ],
              ),
      ),
    );
  }
}
