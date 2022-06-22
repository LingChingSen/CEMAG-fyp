import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_cemag/view/globalMarket.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:fyp_cemag/view/mainscreen.dart';
import 'package:fyp_cemag/view/user.dart';
import 'package:fyp_cemag/view/restock1.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'user.dart';

class ManageStudentsScreen extends StatefulWidget {
  final User user;

  const ManageStudentsScreen({Key key, this.user}) : super(key: key);

  @override
  _ManageStudentsScreenState createState() => _ManageStudentsScreenState();
}

class _ManageStudentsScreenState extends State<ManageStudentsScreen> {

  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');

  int cartitem = 0;
 List _productList = [];
  List _profileList = [];
   ProgressDialog pr;
  String nothing = "";
  int _totaltoken = 0;
  int _token = 0;
  int _totaljelly = 0;
  int _jellybeans = 0;
  int token = 0;
  int jellybeans = 0;
    final now = new DateTime.now();
  TextEditingController _chatController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _testasync();
    _updateToken();
    _updateJellybeans();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Global Market 2"),
      ),
      body: Center(
        child: Column(children: [
          
          if (_productList == null)
            Flexible(child: Center(child: Text(titleCenter)))
          else
            Flexible(child: OrientationBuilder(builder: (context, orientation) {
              return GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 2.1,
                  children: List.generate(_productList.length, (index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
                        child: Container(
                            child: Card(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.indigo[900],
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(1, 1),
                                          ),
                                        ]),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                             
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 5,
                                                          child: Text(
                                                              "Seller",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(":",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                            _productList[index]
                                                                ['username'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 5,
                                                          child: Text("Description",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(":",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                            _productList[index]
                                                                ['description'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 5,
                                                          child: Text("Jellybeans",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(":",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                            _productList[index]
                                                                ['quantity'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 5,
                                                          child: Text("Tokens",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(":",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                            _productList[index]
                                                                ['total'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 10, 0, 0),
                                                      child: MaterialButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          minWidth: 150,
                                                          height: 20,
                                                          child: Text(
                                                            'View Profile',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                            textAlign:
                                                                TextAlign.right,
                                                          ),
                                                          color: Colors.blue,
                                                          onPressed: () => {
                                                                _viewprofile(
                                                                    index)
                                                              }),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 10, 0, 0),
                                                      child: MaterialButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          minWidth: 150,
                                                          height: 20,
                                                          child: Text(
                                                            'Chat',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                            textAlign:
                                                                TextAlign.right,
                                                          ),
                                                          color: Colors.green,
                                                          onPressed: () => {_chat(index)}),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 10, 0, 0),
                                                      child: MaterialButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          minWidth: 150,
                                                          height: 20,
                                                          child: Text(
                                                            'Buy',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                            textAlign:
                                                                TextAlign.right,
                                                          ),
                                                          color: Colors.orange,
                                                          onPressed: () => {
                                                                 _checkToken(index),
                                                              }),
                                                    ),
                                                  ])
                                            ],
                                          )),
                                      ],
                                    )))));
                  }));
            })),
        ]),
      ),

    );
  }
 _totalJellyCalculator(index) {
    String qty = _productList[index]['quantity'];
    _jellybeans = int.parse(jellybeans.toString());
    _totaljelly = _jellybeans + int.parse(qty);
  }

    _checkToken(index){
  _updateToken();
  String total = _productList[index]['total'];
  _token = int.parse(token.toString());
    if (_token < int.parse(total) ) {
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
                builder: (context) => GlobalScreen(user: widget.user)));
        
      } else{
     _buyDialog( index);
      }
       
    
    
  }


  void _buyDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Are you sure you want to buy?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes",
                        style: TextStyle(color: Colors.yellow[600])),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _buyStatus(index);
                      _totalTokenCalculator(index);
                      _totalJellyCalculator(index);
                      _newStatus();
                      _newJellybeans();
                    },
                  ),
                  TextButton(
                      child: Text("No",
                          style: TextStyle(color: Colors.yellow[600])),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }

  void _loadMarket(String nothing) {
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/globalmarket.php"),
        body: {"name": nothing}).then((response) {
      if (response.body == "nodata") {
        Fluttertoast.showToast(
            msg: "No Post Yet!",
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
        _productList = jsondata["sales"];
      }
      setState(() {});
    });
  }

  void _loadProfile() {
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/viewprofile.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body == "nodata") {
        Fluttertoast.showToast(
            msg: "No Posting Yet!",
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
        _profileList = jsondata["profile"];
      }
      setState(() {});
    });
  }

  Future<void> _testasync() async {
    _loadMarket("");
  }

  _totalTokenCalculator(index) {
    String total = _productList[index]['total'];
    _token = int.parse(token.toString());
    _totaltoken = _token - int.parse(total);
  }

  Future<void> _newStatus() async {
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/updatestatus.php"),
        body: {
          "token": _totaltoken.toString(),
          "email": widget.user.email,
        }).then((response) {
      print(response.body);
      if (response.body == "success,,,,,") {
        Fluttertoast.showToast(
            msg: "Successfully update status",
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
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/printjellybeans.php"),
        body: {"email": widget.user.email}).then((response) {
      setState(() {
        jellybeans = int.parse(response.body);
        print(jellybeans);
      });
    });
  }

  void _buyStatus(int index) {
    String _date = DateFormat('yyyy/MM/dd').format(now);
    String id = _productList[index]['id'];
    print(widget.user.email);
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/globalrestock.php"),
        body: {
          "buyer": widget.user.email,
          "id": id,
          "date": _date
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RestockScreen1(user: widget.user)));
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  Future<void> _newJellybeans() async {
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/updatejelly.php"),
        body: {
          "jelly": _totaljelly.toString(),
          "email": widget.user.email,
        }).then((response) {
      print(response.body);
      if (response.body == "success,,,,,") {
        Fluttertoast.showToast(
            msg: "Successfully update status",
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

  void _viewprofile(int index) {
    Widget setupAlertDialoadContainer() {
      return Container(
          height: 150.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 5, 0),
                          child: Text(
                              "Email : " + _profileList[index]['email'],
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.blue[600],
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 5, 0),
                          child: Text("Level : " + _profileList[index]['level'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 5, 0),
                          child: Text("Token : " + _profileList[index]['token'],
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 5, 0),
                          child: Text(
                              "Jellybeans : " +
                                  _profileList[index]['jellybeans'],
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                      ])
                ],
              )));
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('User profile'),
              content: setupAlertDialoadContainer(),
              actions: <Widget>[
                TextButton(
                    child: Text("Cancel",
                        style: TextStyle(color: Colors.yellow[600])),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ]);
        });
  }

  void _chat(int index) {
    Widget setupAlertDialoadContainer() {
      return Container(
        height: 100.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: Column(
        children: [
          Text(
          'Send chat to: ' + _profileList[index]['email'],
          style: TextStyle(
            color: Colors.lightBlue,
          ),
        ),
        TextField(
                    controller: _chatController,
                    decoration: InputDecoration(
                        labelText: 'Enter chat', icon: Icon(Icons.chat)),
                  ),
        ]
      ));
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Chat'),
              content: setupAlertDialoadContainer(),
              
              actions: <Widget>[
                TextButton(
                child: Text("Send",style: TextStyle(
                            color: Colors.yellow[600],
                          )),
                onPressed: () {
                  Navigator.of(context).pop();
                  _sendChat(index);
                },
              ),
                TextButton(
                    child: Text("Cancel",
                        style: TextStyle(color: Colors.yellow[600])),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ]);
        });
  }

  Future<void> _sendChat(int index) async {
    pr = ProgressDialog(context);
    pr.style(
      message: 'Sending...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
        await pr.show();
        String chat = _chatController.text.toString();
        print( _profileList[index]['email']);
        print( widget.user.email);
        http.post(
          Uri.parse("https://crimsonwebs.com/s271738/cemag/php/sendchat.php"),
          body: {
            "sender": widget.user.email,
            "email":  _profileList[index]['email'],
            "chat": chat,
            
        }).then((response) {
            pr.hide().then((isHidden) {
            print(isHidden);
      });
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          _chatController.text = "";
         
  
        });
         Navigator.push(
        context, MaterialPageRoute(builder: (content) =>GlobalScreen(user:widget.user)));
      
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }
  
}