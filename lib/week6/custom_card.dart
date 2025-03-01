import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final bool isCircle;

  const CustomCard(
      {super.key,
      required this.text,
      required this.backgroundColor,
      this.isCircle = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(isCircle ? 50 : 10)),
      child:
          Text(text, style: const TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}

class CustomCounterWidget extends StatefulWidget {
  final String title;
  final Color backgroundColor;
    final Function onplayerwin;
  const CustomCounterWidget(
      {super.key, required this.title, required this.backgroundColor, required this.onplayerwin});
  @override
  _CustomCounterWidgetState createState() => _CustomCounterWidgetState();
}

class _CustomCounterWidgetState extends State<CustomCounterWidget> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter == 21) {
        widget.onplayerwin(widget.backgroundColor);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            '${widget.title}: $_counter',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: const Text('Increment'),
          ),
        ]));
  }
}
