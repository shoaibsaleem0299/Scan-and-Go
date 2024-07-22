import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';

class GuardView extends StatefulWidget {
  const GuardView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GuardScreenState createState() => _GuardScreenState();
}

class _GuardScreenState extends State<GuardView> {
  late PusherClient pusher;
  late Channel channel;

  @override
  void initState() {
    super.initState();
    setupPusher();
  }

  void setupPusher() {
    final options = PusherOptions(
      cluster: 'ap2',
      encrypted: true,
    );

    pusher = PusherClient(
      '03190fe4b82f31581ffe', // Your Pusher key
      options,
      autoConnect: true,
    );

    pusher.connect();

    channel = pusher.subscribe('notify-channel');

    channel.bind('notify-event', (event) {
      final String? data = event!.data;
      print("Received event: $data"); // Print event data to debug

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Notification'),
            content: Text(data!),
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
    });
  }

  @override
  void dispose() {
    pusher.unsubscribe('notify-channel');
    pusher.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Guard'),
        backgroundColor: Colors.blue, // Update as needed
      ),
      body: const Center(
        child: Text("Listening for events..."),
      ),
    );
  }
}
