import 'package:flutter/material.dart';
import '../homeScreen.dart';
import 'constant.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Machine learning',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: HomeScreen(),
    );
  }
}