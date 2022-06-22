import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/guidescreen.dart';
import 'loginscreen.dart';
import 'package:fyp_cemag/view/loginscreen.dart';

import 'package:fyp_cemag/view/user.dart';



class SplashScreens2 extends StatefulWidget {
   final User user;

  const SplashScreens2({Key key, this.user}) : super(key: key);
  @override
  _SplashScreens2State createState() => _SplashScreens2State();
}

class _SplashScreens2State extends State<SplashScreens2> {
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
                
                Image.asset('assets/images/level 2.png')),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Senior Entrepreneur", style: TextStyle(fontSize: 20)),
            ]),
   
            
        ]
        ),
        
      ),
    );
  }



  
}