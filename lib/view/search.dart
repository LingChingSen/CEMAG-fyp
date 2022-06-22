import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_cemag/view/mainscreen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/user.dart';
import 'package:fyp_cemag/view/restock1.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SearchScreen extends StatefulWidget {
  final User user;
  const SearchScreen({Key key, this.user}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List _playerList = [];
   ProgressDialog pr;
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');
  int cartitem = 0;
  String nothing = "";
  int _totaltoken = 0;
  int _token = 0;
  int _totaljelly = 0;
  int _jellybeans = 0;
  int token = 0;
  int jellybeans = 0;
    final now = new DateTime.now();
  TextEditingController _chatController = new TextEditingController();
TextEditingController _srcController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _testasync();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
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
          Column(children: [
            TextFormField(
              controller: _srcController,
              decoration: InputDecoration(
                hintText: "Search Players",
                suffixIcon: IconButton(
                  onPressed: () =>_loadPlayers (_srcController.text),
                  icon: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.white24)),
              ),
            )
          ]),
          Flexible(
              flex: 9,
              child: ListView.builder(
                  itemCount: _playerList.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.yellow[600],
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  ),
                                ]),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
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
                                                          15, 15, 5, 0),
                                                      child: Text(
                                                          "Player : " +
                                                              _playerList[
                                                                      index]
                                                                  ['name'],
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: TextStyle(
                                                            color: Colors
                                                                  .blue[600],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15)),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          15, 15, 5, 0),
                                                      child: Text(
                                                          "Level : " +
                                                              _playerList[
                                                                      index][
                                                                  'level'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          15, 15, 5, 0),
                                                      child: Text(
                                                          "Tokens : " +
                                                              _playerList[
                                                                      index]
                                                                  ['token'],
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15)),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          15, 15, 5, 0),
                                                      child: Text(
                                                          "Jellybeans : " +
                                                              _playerList[
                                                                      index]
                                                                  ['jellybeans'],
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15)),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text(""),
                                                  ])
                                            ],
                                          )),
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
                                                    
                                                  ])
                                            ],
                                          )),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ));
                  })),
        ]),
      ),
    );
  }

 


  void _loadPlayers(String name) {
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/loadplayers.php"),
        body: {"name": name}).then((response) {
      if (response.body == "nodata") {
        Fluttertoast.showToast(
            msg: "No Player Found !",
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
        _playerList = jsondata["players"];
      }
      setState(() {});
    });
  }


  Future<void> _testasync() async {
    _loadPlayers("");
  }

  
  

  void _chat(int index) {
    Widget setupAlertDialoadContainer() {
      return Container(
        height: 100.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: Column(
        children: [
          Text(
          'Send chat to: ' + _playerList[index]['email'],
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
        print( _playerList[index]['email']);
        print( widget.user.email);
        http.post(
          Uri.parse("https://crimsonwebs.com/s271738/cemag/php/sendchat.php"),
          body: {
            "sender": widget.user.email,
            "email":  _playerList[index]['email'],
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
        context, MaterialPageRoute(builder: (content) =>SearchScreen(user:widget.user)));
      
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
