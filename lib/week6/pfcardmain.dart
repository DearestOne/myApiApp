import 'package:flutter/material.dart';
import 'package:myapiapp/week6/profile_card.dart';

class MainPF extends StatelessWidget {
  final ThemeMode theme;
  final Function toggleTheme;
  const MainPF({super.key, required this.theme, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed: () =>
              toggleTheme()
            ,
          ),]
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileCard(  
                name: "Natthaphon Rueangwaraphit",
                position: "Student",
                email: "rueangwaraphit_n@silplkorn.edu",
                phone: "061-81x-xxxx",
                imageURL: "https://static.vecteezy.com/system/resources/thumbnails/009/273/280/small/concept-of-loneliness-and-disappointment-in-love-sad-man-sitting-element-of-the-picture-is-decorated-by-nasa-free-photo.jpg")
          ],
        ),
      ),
    );
  }
}
