import 'package:flutter/material.dart';
import 'package:myapiapp/week5/product_main.dart';
import 'package:firebase_core/firebase_core.dart';
// homework2
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      // home: FireStoreDemo(),
      home: Product(),
    );
  }
}