import 'package:flutter/material.dart';
import 'dart:async';

class Traffic extends StatefulWidget {
  const Traffic({super.key});

  @override
  State<Traffic> createState() => _TrafficState();
}

class _TrafficState extends State<Traffic> {
  int status = 0;
  int time = 0;
  Color color = Colors.black;
  List<double> opacity = [1, 0.3, 0.3];

  void change() {
    setState(() {
      if (status == 0) {
        opacity = [0.3, 0.3, 1];
        status = 1;
        color = Colors.green;
      } else if (status == 1) {
        opacity = [0.3, 1, 0.3];
        status = 2;
        color = const Color.fromARGB(255, 143, 176, 0);
      } else {
        opacity = [1, 0.3, 0.3];
        status = 0;
        color = Colors.red;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    timer();
  }

  void timer() async {
    while (true) {
      change(); // Update status

      if (status == 0) {
        setState(() {
          time = 30;
        });
      } else if (status == 1) {
        setState(() {
          time = 20;
        });
      } else if (status == 2) {
        setState(() {
          time = 5;
        });
      }

      while (time >= 0) {
        await Future.delayed(const Duration(seconds: 1)); // Non-blocking delay
        setState(() {
          time -= 1;
        });
        print(time);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Main Page'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: AnimatedOpacity(
                key: ValueKey<int>(time),
                opacity: 1.0,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  '$time',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: color),
                ),
              ),
            ),
            const SizedBox(height: 15),
            AnimatedOpacity(
              opacity: opacity[0],
              duration: const Duration(milliseconds: 500),
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.red,
              ),
            ),
            const SizedBox(height: 15),
            AnimatedOpacity(
              opacity: opacity[1],
              duration: const Duration(milliseconds: 500),
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.yellow,
              ),
            ),
            const SizedBox(height: 15),
            AnimatedOpacity(
              opacity: opacity[2],
              duration: const Duration(milliseconds: 500),
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.green,
              ),
            ),
            const SizedBox(height: 15),
          ],
        )));
  }
}
