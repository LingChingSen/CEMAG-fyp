import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/loginscreen.dart';
//import 'package:bunplanet/view/mainscreen.dart';
//import 'package:bunplanet/view/registrationscreen.dart';

import 'model/themes.dart';
import 'view/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.darktheme,
      routes: <String, WidgetBuilder>{
        '/loginscreen': (BuildContext context) => new LoginScreen(),
        //'/registerscreen': (BuildContext context) => new RegistrationScreen(),
        //'/mainscreen': (BuildContext context) => new MainScreen(),
      },
      title: 'CEMAG',
      home: SplashScreen(),
    );
  }
}