import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String position;
  final String email;
  final String phone;
  final String imageURL;

  const ProfileCard(
      {super.key,
      required this.name,
      required this.position,
      required this.email,
      required this.phone,
      required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Column(
          children: [
            CircleAvatar(
                radius: 30,
                child: ClipOval(
                    child: Image.network(
                  imageURL,
                ))),
            Text(name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(position,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.email,
                  color: Colors.blueAccent,
                ),
                Text(email, style: const TextStyle(fontSize: 15)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone, color: Colors.green),
                Text(phone, style: const TextStyle(fontSize: 15)),
              ],
            ),
          ],
        )));
  }
}
