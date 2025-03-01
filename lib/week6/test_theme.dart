import 'package:flutter/material.dart';

class TestTheme extends StatelessWidget {
  final Theme theme;
  const TestTheme({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Main Page01'),
          backgroundColor: Colors.blue,
          actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {},
          ),]
        ),
        body: 
    Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Hello World', style: Theme.of(context).textTheme.bodyMedium),
      ElevatedButton(
        onPressed: () {},
        child: const Text("Press Me!"),
      )
    ]))
    );
  }
}
