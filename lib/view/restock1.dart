import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/user.dart';
import 'package:fyp_cemag/view/mainscreen.dart';
import 'package:fyp_cemag/view/globalMarket.dart';
import 'package:fyp_cemag/view/aiMarket.dart';

class RestockScreen1 extends StatefulWidget {
  final User user;
 
  const RestockScreen1({Key key, this.user}) : super(key: key);

  @override
  _RestockScreen1State createState() => _RestockScreen1State();
}

class _RestockScreen1State extends State<RestockScreen1> {
  List _productList = [];
  String _titlecenter = "Loading...";
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');
  TextEditingController _srcController = new TextEditingController();
  int cartitem = 2;

  get user => null;
  Material homeText(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(10.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      heading,
                      style: TextStyle(
                        color: new Color(color),
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(12.0),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Restock"),
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
        child: Column(children: [
          SizedBox(height: 50),
          Flexible(
              flex: 15,
              child: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            
             children: <Widget>[
              MaterialButton(
                onPressed: () => {Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => AiScreen(user: widget.user)))},
                color: Colors.orange[400],
                padding: EdgeInsets.all(50.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.store_mall_directory_outlined,size: 45),
                    Text("AI Market",style: TextStyle(fontSize: 20))
                  ],
                ),
              ),

              MaterialButton(
                onPressed: () => {Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>GlobalScreen(user: widget.user)))},
                color: Colors.blueGrey[600],
                padding: EdgeInsets.all(50.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.store_mall_directory_outlined,size:45),
                    Text("Global Market",style: TextStyle(fontSize: 20))
                  ],
                ),
              ),

             
            ],
            
            staggeredTiles: [
              StaggeredTile.extent(2, 180.0),
              StaggeredTile.extent(2, 180.0),
             
              
            ],
          ),
              ),
        ]),
      ),
    );
  }





 
}
