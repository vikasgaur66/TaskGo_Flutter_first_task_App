// main.dart
import 'package:calculator/dashbord.dart';
import 'package:calculator/welcomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(taskbar());
}

class taskbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task Go",
      debugShowCheckedModeBanner: false,
      //
      home: welcomeScreen(),
    );
  }
}

class dashbords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    return dashbord();
  }
}
