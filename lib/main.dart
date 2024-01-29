import 'package:flutter/material.dart';
import 'package:food_app/home_screen.dart';
import 'package:food_app/menu.dart';
import 'package:food_app/testui.dart';
import 'package:food_app/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
