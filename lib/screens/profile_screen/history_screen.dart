import 'package:flutter/material.dart';
import 'package:frontend/constants/app_urls.dart';
import 'package:frontend/screens/profile_screen/profile_view.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<dynamic> orderReceipts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrderHistory();
  }

  Future<void> fetchOrderHistory() async {
    String? token = await userToken();
    try {
      var response = await Dio().post(
        '${AppURL.BaseURL}/api/order',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      print(response.data);

      if (response.statusCode == 200) {
        setState(() {
          orderReceipts = response.data['data'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load order history');
      }
    } catch (e) {
      throw Exception('Failed to load order history: $e');
    }
  }

  Future<String?> userToken() async {
    var sharedPref = await SharedPreferences.getInstance();
    String? user_token = sharedPref.getString(ProfileViewState.tokenKey);
    return user_token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order History",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: ListView.builder(
                itemCount: orderReceipts.length,
                itemBuilder: (context, index) {
                  final order = orderReceipts[index];
                  return ListTile(
                    title: Text('Order ID: ${order['id']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Amount: \$${order['total_amount']}'),
                        Text('Status: ${order['status']}'),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: Icon(
                      order['status'] == 'PAID'
                          ? Icons.check_circle
                          : Icons.hourglass_empty,
                      color: order['status'] == 'PAID'
                          ? Colors.green
                          : Colors.orange,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
