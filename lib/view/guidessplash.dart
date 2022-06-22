import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/guidescreen.dart';
import 'loginscreen.dart';
import 'package:fyp_cemag/view/loginscreen.dart';

import 'package:fyp_cemag/view/user.dart';



class SplashScreens extends StatefulWidget {
   final User user;

  const SplashScreens({Key key, this.user}) : super(key: key);
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  int level= 0;
  @override
  void initState() {
    super.initState();
  
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (content) => GuideScreen( user: widget.user,))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children:[
            Container(
              
                margin: EdgeInsets.fromLTRB(100, 50, 100, 10),
                child: 
                
                Image.asset('assets/images/level1.png')),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Junior Entrepreneur", style: TextStyle(fontSize: 20)),
            ]),
   
            
        ]
        ),
        
      ),
    );
  }



  
}