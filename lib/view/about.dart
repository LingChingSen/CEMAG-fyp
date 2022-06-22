import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/user.dart';
import 'package:fyp_cemag/view/restock1.dart';
import 'package:fyp_cemag/view/mainscreen.dart';




class AboutScreen extends StatefulWidget {
  final User user;
  const AboutScreen({Key key, this.user}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  int _itemCount = 1;
  List _jellybeansList = [];
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');
  int cartitem = 0;
  String _titlecenter = "";
  int _total = 0;
  int _totaltoken = 0;
  int _token = 0;
  int _jelly = 0;
  int _totaljelly= 0;
  int token = 0;
  int jellybeans = 0;
  final now = new DateTime.now();

  get pr => null;
 

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final now = new DateTime.now();
    String _date = DateFormat('yMd').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MainScreen(
                          user: widget.user,
                        )));
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('A littel information about us...',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Container(
                margin: EdgeInsets.fromLTRB(50, 50, 50, 70),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(children: [
                    Text(
                        'Welcome player, Below are the information about us:',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Text(
                        '1. The objective of this app is to let children have entrepreneurial knowledge.  ',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Text(
                        '2. Children can experience trading and online business in this app game. ',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Text(
                        '3. This project is actually support by UUM Malaysia and it is a final year project. ',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Text(
                        '4. The project has been developed by a UUM student which is for final year project propose. ',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Text(
                        '5. It is totally suitable for children and parents to guide in playing this game.',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Text(
                        '6. This app are using Yeah Hosting to provide the web hosting service. ',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                     SizedBox(height: 20),
                    
                    
                  
                  ]),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),  
      ),
    );
  }
  

  
}
