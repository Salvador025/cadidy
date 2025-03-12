import 'package:flutter/material.dart';
import 'package:cadidy/screens/dashboard/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadidy',
      home: Scaffold(
        body: Home()
      ),
    );
  }
}