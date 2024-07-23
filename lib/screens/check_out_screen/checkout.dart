import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_urls.dart';
import 'package:frontend/screens/home_screen/home_view.dart';
import 'package:frontend/screens/navigation_screen/navigation_view.dart';
import 'package:frontend/screens/profile_screen/profile_view.dart';
import 'package:frontend/widgets/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkout Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CheckoutPage(),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Variables to store user input
  String fullName = '';
  String cardNumber = '';
  String expirationDate = '';
  String cvv = '';

  processPayment() async {
    String? token = await userToken();
    final dio = Dio();
    final url = "${AppURL.BaseURL}/api/checkout";

    final data = {
      'fullName': fullName,
      'cardNumber': cardNumber,
      'expirationDate': expirationDate,
      'cvv': cvv,
    };

    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Message'),
              content: const Text('Payment Processed Successfully'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavigationView(),
                      ),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showErrorDialog("Failed to process payment. Please try again.");
      }
    } catch (e) {
      if (e is DioException) {
        print("DioException: ${e.response?.data}");
      } else {
        print("Error: $e");
      }
      showErrorDialog("An error occurred. Please try again.");
    }
  }

  Future<String?> userToken() async {
    var sharedPref = await SharedPreferences.getInstance();
    String? user_token = sharedPref.getString(ProfileViewState.tokenKey);
    return user_token;
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your details:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                labelText: "Full Name",
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 237, 237, 237),
                prefixIcon: const Icon(Icons.person),
              ),
              onChanged: (value) {
                setState(() {
                  fullName = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                labelText: "Enter Card Number",
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 237, 237, 237),
                prefixIcon: const Icon(Icons.payments_outlined),
              ),
              onChanged: (value) {
                setState(() {
                  cardNumber = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      labelText: "Expiry Date",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 237, 237, 237),
                      prefixIcon: const Icon(Icons.date_range_rounded),
                    ),
                    onChanged: (value) {
                      setState(() {
                        expirationDate = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10.0),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      labelText: "CVV",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 237, 237, 237),
                      prefixIcon: const Icon(Icons.numbers),
                    ),
                    onChanged: (value) {
                      setState(() {
                        cvv = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            AppButton(
              buttonText: "Process Payment",
              onButtonTap: () {
                if (fullName.isNotEmpty &&
                    cardNumber.isNotEmpty &&
                    expirationDate.isNotEmpty &&
                    cvv.isNotEmpty) {
                  processPayment();
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please fill in all the fields.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeView()));
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
