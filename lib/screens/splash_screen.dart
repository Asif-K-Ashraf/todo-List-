import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/screens/listing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => TodoScreen()),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "ToDo List",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900,color: Colors.blue),
        ),
      ),
    );
  }
}
