import 'package:flutter/material.dart';
import 'package:myapiapp/week6/cusmain.dart';
import 'package:myapiapp/week6/pfcardmain.dart';
import 'package:myapiapp/week6/test_theme.dart';
import 'package:myapiapp/week6/traffic.dart';
import 'package:myapiapp/week5/product_main.dart';
import 'package:firebase_core/firebase_core.dart';

// homework2
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  ThemeMode _theme = ThemeMode.light;

  MyApp({super.key});
  void toggleTheme() {
    print('toggleTheme');
    void setState() {
      if (_theme == ThemeMode.light) {
        _theme = ThemeMode.dark;
      } else {
        _theme = ThemeMode.light;
      }
    }
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          textTheme:
              const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        ), // ธีมมืด
        theme: ThemeData.light().copyWith(
            textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.black))), // ธีมสว่าง
        themeMode: widget._theme, // เปลี8ยนตามระบบ (Auto)
        home: const Traffic());
  }
}
