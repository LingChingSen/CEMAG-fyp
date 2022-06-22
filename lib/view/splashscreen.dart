import 'dart:async';
import 'package:flutter/material.dart';
import 'loginscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (content) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(100, 50, 100, 10),
                child: Image.asset('assets/images/cemag.png')),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Welcome to CEMAG", style: TextStyle(fontSize: 20)),
            ])
          ],
        ),
      ),
    );
  }
}