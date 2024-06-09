import 'package:flutter/material.dart';
import 'package:frontend/screens/profile_screen/profile_screen.dart';

class UserTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  const UserTile({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
        title: const Text(
          "Delivered to",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        trailing: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            icon: const Icon(Icons.person_2_rounded)));
  }
}
