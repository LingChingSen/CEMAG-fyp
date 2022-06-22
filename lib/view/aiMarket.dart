import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/user.dart';
import 'package:fyp_cemag/view/restock1.dart';
import 'package:fyp_cemag/view/mainscreen.dart';




class AiScreen extends StatefulWidget {
  final User user;
  const AiScreen({Key key, this.user}) : super(key: key);

  @override
  _AiScreenState createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
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
    _totalCalculator();
    _updateToken();
    _updateJellybeans();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final now = new DateTime.now();
    String _date = DateFormat('yMd').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("AI Market"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => RestockScreen1(
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
              Text('Welcome to AI Market',
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
                        'You can restock in AI market instead of Global Market.The price per jellybenas is 10 tokens.',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Text(
                        'Please select the quantity that you want to buy at below:',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        
                        _itemCount != 0
                        
                            ? new IconButton(
                                icon: new Icon(Icons.remove),
                               onPressed: () {_totalCalculatorR(); },
                                
                              )
                              
                            : new Container(),
                        new Text(_itemCount.toString()),
                        new IconButton(
                            icon: new Icon(Icons.add),
                            onPressed: () {_totalCalculatorA(); },),
                          
                      ],
                      
                    ),
                   
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 5, 0),
                      child: Text("Total: "+_total.toString()+" tokens",
                          style: TextStyle(
                              color: Colors.red[600],
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      minWidth: 200,
                      height: 35,
                      child: Text('Buy', style: TextStyle(color: Colors.white)),
                      color: Colors.brown,
                      onPressed: () {
                        _checkToken();
                       
                       
                        
                },
                
                      
                    )
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
  

  _totalCalculator(){

  _total = 0;
    _total = _total + _itemCount*10; 
    
  }

  _totalTokenCalculator(){

  
  _token = int.parse(token.toString())   ;

    _totaltoken = _token - _total;
   
  
    
  }

   _totalJellyCalculator(){

  
  _jelly = int.parse(jellybeans.toString())   ;

    _totaljelly = _jelly + _itemCount;
   
  
    
  }
_totalCalculatorR(){
  setState(() => _itemCount--);
  _total = 0;
    _total = _total + _itemCount*10; 
    
  }
  _totalCalculatorA(){
  setState(() => _itemCount++);
  _total = 0;
    _total = _total + _itemCount*10; 
    
  }

    _checkToken(){
  _updateToken();
  _token = token;
    if (_token < _total ) {
        Fluttertoast.showToast(
            msg:
                "Not enough tokens!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AiScreen(user: widget.user)));
        
      } else{
        _totalTokenCalculator();
        _totalJellyCalculator();
        _newToken();
        _newJellybeans();
        _buyStatus();
      }
       
    
    
  }

  Future<void> _buyStatus() async {
    String _date = DateFormat('yyyy/MM/dd').format(now);
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/airestock.php"),
        body: {
          "qty": _itemCount.toString(),
          "email": widget.user.email,
          "total": _total.toString(),
          "date": _date
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg:
                "Successfully Restock! Have Fun!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
            
     
         
      } else {
        Fluttertoast.showToast(
            msg: "You have reach the limited amount for today!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
            
     
      }
      
    });
    
  }
  Future<void> _newJellybeans() async {
    
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/updatejelly.php"),
        body: {
          "jelly":_totaljelly.toString(),
          "email": widget.user.email,
          
        }).then((response) {
      print(response.body);
      if (response.body == "success,,,,,") {
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
         Navigator.push(context,
            MaterialPageRoute(builder: (content) => MainScreen(user: user)));
     
      } else {
        Fluttertoast.showToast(
            msg: "Failed to update status",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
     
      }
      
    });
    
  }
  Future<void> _newToken() async {
    
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/updatestatus.php"),
        body: {
          "token":_totaltoken.toString(),
          "email": widget.user.email,
          
        }).then((response) {
      print(response.body);
      if (response.body == "success,,,,,") {
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
         Navigator.push(context,
            MaterialPageRoute(builder: (content) => MainScreen(user: user)));
     
      } else {
        Fluttertoast.showToast(
            msg: "Failed to update status",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
     
      }
      
    });
    
  }
   void _updateToken() {
    print(widget.user.email);
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/printtoken.php"),
        body: {"email": widget.user.email}).then((response) {
      setState(() {
        token = int.parse(response.body);
        print(token);
        
      });
    });
  }
  void _updateJellybeans() {
    print(widget.user.email);
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/printjellybeans.php"),
        body: {"email": widget.user.email}).then((response) {
      setState(() {
        jellybeans = int.parse(response.body);
        print(jellybeans);
        
      });
    });
  }

}
