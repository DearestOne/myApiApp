import 'package:flutter/material.dart';
import 'package:myapiapp/week6/custom_card.dart';


class MyMain extends StatefulWidget {
  const MyMain({super.key});

  @override
  State<MyMain> createState() => _MyMainState();
}

class _MyMainState extends State<MyMain> {
  Color winplayercolor = Colors.white;

  void setWinerColor(Color color) {
    setState(() {
      winplayercolor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Main Page'),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: winplayercolor,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomCard(text: "Hello, Flutter!", backgroundColor: Colors.greenAccent, isCircle: true,),
            const SizedBox(height: 10),
            const CustomCard(text: "Welcome to Widgets", backgroundColor: Colors.redAccent,),
            CustomCounterWidget(title: "teamA", backgroundColor: Colors.blueAccent, onplayerwin: setWinerColor),
            CustomCounterWidget(title: "teamB", backgroundColor: Colors.redAccent, onplayerwin: setWinerColor),
          ],
        )));
  }
}
