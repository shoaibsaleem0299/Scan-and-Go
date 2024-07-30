import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/models/pusher_channels.dart';
import 'package:frontend/screens/login_screen/login.dart';
import 'package:frontend/screens/splash_screen/splash_view.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../models/pusher_channels.dart';

class GuardView extends StatefulWidget {
  const GuardView({super.key});

  @override
  State<GuardView> createState() => _GuardViewState();
}

class _GuardViewState extends State<GuardView> {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  List<String> eventLogs = [];
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _setupPusher();
  }

  void _setupPusher() async {
    void onEvent(PusherEvent event) {
      setState(() {
        eventLogs
            .add("Event: ${event.eventName}, Data: ${event.data['notify']}");
      });

      NotificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: 'Event Received',
        body: 'Event: ${event.eventName}, Data: ${event.data['notify']}',
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Meassage'),
            content: Text('${event.data}'),
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
      setState(() {
        isConnected = true;
      });
    } catch (e) {
      print("Error : $e");
      setState(() {
        isConnected = false;
      });
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(isConnected ? Icons.check_circle : Icons.error,
                        color: isConnected ? AppColor.primary : Colors.red),
                    const SizedBox(width: 10),
                    Text(isConnected ? "Connected" : "Disconnected"),
                  ],
                ),
                Row(
                  children: [
                    const Text("Log Out"),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      color: const Color.fromARGB(255, 188, 23, 23),
                      onPressed: () async {
                        var sharePref = await SharedPreferences.getInstance();
                        sharePref.setString(SplashScreenState.loggedInKey, "");
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            // ignore: deprecated_member_use
                            return WillPopScope(
                              onWillPop: () async => false,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        );

                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const LogIn()),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Event Log:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: eventLogs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(eventLogs[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: _setupPusher, child: const Text("Reconnect")),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 188, 23, 23))),
                  onPressed: () {
                    setState(() {
                      eventLogs.clear();
                    });
                  },
                  child: const Text(
                    "Clear Log",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
