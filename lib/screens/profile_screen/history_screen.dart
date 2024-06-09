import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const List<Map<String, String>> orderReceipts = [
    {
      'orderId': '001',
      'name': 'Product A',
      'totalAmount': '\$50.00',
      'status': 'Delivered',
    },
    {
      'orderId': '002',
      'name': 'Product B',
      'totalAmount': '\$150.00',
      'status': 'Pending',
    },
    {
      'orderId': '003',
      'name': 'Product C',
      'totalAmount': '\$250.00',
      'status': 'Cancelled',
    },
    {
      'orderId': '004',
      'name': 'Product D',
      'totalAmount': '\$350.00',
      'status': 'Shipped',
    },
    {
      'orderId': '005',
      'name': 'Product E',
      'totalAmount': '\$450.00',
      'status': 'Delivered',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order History",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: orderReceipts.length,
          itemBuilder: (context, index) {
            final order = orderReceipts[index];
            return ListTile(
              title: Text('Order ID: ${order['orderId']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${order['name']}'),
                  Text('Total Amount: ${order['totalAmount']}'),
                  Text('Status: ${order['status']}'),
                ],
              ),
              isThreeLine: true,
              trailing: Icon(
                order['status'] == 'Delivered'
                    ? Icons.check_circle
                    : order['status'] == 'Pending'
                        ? Icons.hourglass_empty
                        : order['status'] == 'Cancelled'
                            ? Icons.cancel
                            : Icons.local_shipping,
                color: order['status'] == 'Delivered'
                    ? Colors.green
                    : order['status'] == 'Pending'
                        ? Colors.orange
                        : order['status'] == 'Cancelled'
                            ? Colors.red
                            : Colors.blue,
              ),
            );
          },
        ),
      ),
    );
  }
}
