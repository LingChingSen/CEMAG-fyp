import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fyp_cemag/view/guidesplash2.dart';
import 'package:fyp_cemag/view/guidesplash3.dart';
import 'package:fyp_cemag/view/guidesplash4.dart';
import 'package:fyp_cemag/view/guidessplash.dart';
import 'package:fyp_cemag/view/restock1.dart';
import 'package:fyp_cemag/view/search.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_cemag/view/user.dart';
import 'package:fyp_cemag/view/mydrawer.dart';
import 'package:fyp_cemag/view/sell.dart';
import 'package:fyp_cemag/view/mission.dart';
import 'package:fyp_cemag/view/notification.dart';


class MainScreen extends StatefulWidget {
  final User user;
 
  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  List _productList = [];
  String _titlecenter = "Loading...";
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');
  TextEditingController _srcController = new TextEditingController();
  int newnoti = 0;
  int updatenoti = 0;
  int _totalnoti = 0;
  int _newnoti = 0;
  int _updatenoti = 0;
  int level = 0;

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
    _totalNotiCalculator();
    _updateStatus();
    _testasync();
    _loadChat();
   _loadUpdate();
   _updateLevel();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("CEMAG"),
        actions: [
          TextButton.icon(
              onPressed: () => {_goNoti()},
              icon: Icon(
                Icons.notification_important,
                color: Colors.white,
              ),
              label: Text(
                _totalnoti.toString(),
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      drawer: MyDrawer(user: widget.user),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            TextFormField(
              controller: _srcController,
              decoration: InputDecoration(
                hintText: "Search Players",
                suffixIcon: IconButton(
                  onPressed: () => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => SearchScreen(user: widget.user))),
                  icon: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.white24)),
              ),
            )
          ]),
          SizedBox(height: 50),
          Flexible(
              flex: 15,
              child: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 10.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            
             children: <Widget>[
              MaterialButton(
                onPressed: () => {Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => RestockScreen1(user: widget.user)))},
                color: Colors.orange,
                padding: EdgeInsets.all(50.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.store_mall_directory_outlined,size: 35),
                    Text("Restock",style: TextStyle(fontSize: 11))
                  ],
                ),
              ),

              MaterialButton(
                
                onPressed: () => {
                  Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => SellScreen(user: widget.user)))},
                color: Colors.blueGrey,
                padding: EdgeInsets.all(50.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.attach_money,size: 35),
                    Text("Sell",style: TextStyle(fontSize: 11))
                  ],
                ),
              ),

              MaterialButton(
                onPressed: () => {Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => MissionScreen(user: widget.user)))},
                color: Colors.blueAccent,
                padding: EdgeInsets.all(50.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.assignment,size: 35),
                    Text("Mission",style: TextStyle(fontSize: 11))
                  ],
                ),
              ),

              MaterialButton(
                onPressed: () => {_loadScreens()},
                color: Colors.redAccent,
                padding: EdgeInsets.all(50.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.article_rounded,size: 35),
                    Text("Guideline",style: TextStyle(fontSize: 11))
                  ],
                ),
              ),
            ],
            
            staggeredTiles: [
              StaggeredTile.extent(1, 150.0),
              StaggeredTile.extent(1, 150.0),
              StaggeredTile.extent(1, 150.0),
              StaggeredTile.extent(1, 150.0),
              
            ],
          ),
              ),
        ]),
      ),
    );
  }
   void _updateLevel() {
    print(widget.user.email);
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/printlevel.php"),
        body: {"email": widget.user.email}).then((response) {
      setState(() {
        level = int.parse(response.body);
        print(level);
        
      });
    });
  }
 void _loadScreens() {
    print(level);
     if (level == 1) {
  Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => SplashScreens(user: widget.user)));
   
    }else if (level == 2) {
  Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => SplashScreens2(user: widget.user)));
    } else if (level == 3) {
  Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => SplashScreens3(user: widget.user)));
    }else if (level == 4) {
  Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => SplashScreens4(user: widget.user)));
    }
  }



  void _loadProducts(String prname) {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/loadusers.php"),
        body: {"prname": prname}).then((response) {
      if (response.body == "nodata") {
        Fluttertoast.showToast(
            msg: "No users Found!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.red,
            fontSize: 20.0);
        return;
      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);
        _productList = jsondata["products"];
        _titlecenter = "";
      }
      setState(() {});
    });
  }

  Future<void> _testasync() async {
    _loadProducts("");
  }

  

  _goNoti() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => NotificationScreen1(user: widget.user)));
  }
  _totalNotiCalculator(){
    _newnoti = int.parse(newnoti.toString());
    _updatenoti = int.parse(updatenoti.toString());
    _totalnoti = _newnoti + _updatenoti ;
  }

  void _loadChat() {
    print(widget.user.email);
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/chatnoti.php"),
        body: {"email": widget.user.email}).then((response) {
      setState(() {
        newnoti = int.parse(response.body);
        print(newnoti);
        _totalNotiCalculator();
      });
    });
  }
  void _loadUpdate() {
    print(widget.user.email);
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/updatenoti.php"),
        body: {"email": widget.user.email}).then((response) {
      setState(() {
        updatenoti = int.parse(response.body);
        print(updatenoti);
        _totalNotiCalculator();
      });
    });
  }
   void _updateStatus() {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/printstatus.php"),
        body: { 
          "email": widget.user.email,
        }).then((response) {
      print(response.body);
      if (response.body == "success,,,,,,") {
        Fluttertoast.showToast(
            msg:
                "Successfully update status",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
            List userdata = response.body.split(",");
        User user = User(
            name: userdata[1],
            age: userdata[2],
            level: userdata[3],
            token: userdata[4],
            jellybeans: userdata[5],
            status: userdata[6]); 

      } 
      
    });
  }
}
