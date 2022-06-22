import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/user.dart';
import 'package:fyp_cemag/view/restock1.dart';
import 'package:fyp_cemag/view/mainscreen.dart';




class GuideScreen extends StatefulWidget {
  final User user;
  const GuideScreen({Key key, this.user}) : super(key: key);

  @override
  _GuideScreenState createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
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
        title: Text("Guideline"),
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
              Text('Let us guide you how to play!',
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
                        'Welcome to the guidline page. Below are the guidlines to guide you how to play this game:',
                        style: TextStyle(
                           color: Colors.red[600],
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Text(
                        '1. You can restock jellybeans in AI Market to complete the mission. ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Text(
                        '2. You can also restock jellybeans in Global Market by buying with other players to complete the mission. ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Text(
                        '3. In the global market you are able to view players profile. It will shows the player details including level and tokens. ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Text(
                        '4. You are also able to chat with player in Global Market to negotiate the price or get promotion and discount by sending them message ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Text(
                        '5. You are able to sell your jellybeans in Global Market in the Sell function. You can get the profit from selling your jelly beans in a higher price. ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Text(
                        '6. You can press the "+" button at the bottom left in the sell function to post your sales. Just fill in all the details and press "Post" ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                     SizedBox(height: 20),
                    Text(
                        '7. The post are able to delete. When you delete the post will be deleted in Global Market as well. Please make sure you consider before doing it ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                     SizedBox(height: 20),
                    Text(
                        '8. To get more experince and level up, you have to complete the mission base on the mission requirement. The mission requirement are able to complete easily',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Text(
                        '9. You are able to view your achivement in Guideline funtion. The medal will shown in 3 seconds before get into the Guideline Screen',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    Text(
                        '10. To check your sales, you can click on the update notification function and collect your sales. All the details will be displayed. ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                     SizedBox(height: 20),
                    Text(
                        '11. You can also check the replies in chat notification. Click on the reply button you can reply the chat. The chats are able to delete.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    
                    
                  
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
