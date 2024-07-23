import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/models/pusher_channels.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import '../../models/pusher_channels.dart';

class GuardView extends StatefulWidget {
  const GuardView({super.key});

  @override
  State<GuardView> createState() => _GuardViewState();
}

class _GuardViewState extends State<GuardView> {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  @override
  void initState() {
    super.initState();
    _setupPusher();
  }

  void _setupPusher() async {
    void onEvent(PusherEvent event) {
      NotificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: 'Event Received',
        body: 'Event: ${event.eventName}, Data: ${event.data}',
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Event Received'),
            content: Text('Event: ${event.eventName}, Data: ${event.data}'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    try {
      await pusher.init(
          apiKey: '9360da808376cfb71c13', cluster: 'ap1', onEvent: onEvent);
      await pusher.subscribe(channelName: "notify-channel");
      await pusher.connect();
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Guard'),
        backgroundColor: AppColor.primary,
      ),
      body: const Center(
        child: Text("Listening for events..."),
      ),
    );
  }
}
