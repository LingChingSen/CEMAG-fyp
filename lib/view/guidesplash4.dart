import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/guidescreen.dart';
import 'loginscreen.dart';
import 'package:fyp_cemag/view/loginscreen.dart';

import 'package:fyp_cemag/view/user.dart';



class SplashScreens4 extends StatefulWidget {
   final User user;

  const SplashScreens4({Key key, this.user}) : super(key: key);
  @override
  _SplashScreens4State createState() => _SplashScreens4State();
}

class _SplashScreens4State extends State<SplashScreens4> {
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
                
                Image.asset('assets/images/level4.png')),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Expert Entrepreneur", style: TextStyle(fontSize: 20)),
            ]),
   
            
        ]
        ),
        
      ),
    );
  }



  
}