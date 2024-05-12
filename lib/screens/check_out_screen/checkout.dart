import 'package:flutter/material.dart';
import 'package:frontend/screens/navigation_screen/navigation_view.dart';
import 'package:frontend/widgets/app_button.dart';
import 'package:frontend/widgets/custom_user_inputfield.dart';

class CheckoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkout Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckoutPage(),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Variables to store user input
  String fullName = '';
  String cardNumber = '';
  String expirationDate = '';
  String cvv = '';

  void processPayment() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Message'),
          content: Text('Payment Processed Successfully'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
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
                        title: Text('Error'),
                        content: Text('Please fill in all the fields.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationView()));
                            },
                            child: Text('OK'),
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
