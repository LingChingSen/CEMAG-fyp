import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_cemag/view/mainscreen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/user.dart';
import 'package:fyp_cemag/view/notification.dart';
import 'package:progress_dialog/progress_dialog.dart';



class UpdateScreen extends StatefulWidget {
  final User user;
  const UpdateScreen({Key key, this.user}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List _chatList = [];
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');
  int cartitem = 0;
  String _titlecenter = "";
  TextEditingController _chatController = new TextEditingController();
  ProgressDialog pr;


  @override
  void initState() {
    super.initState();
    _loadChat();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final now = new DateTime.now();
    String _date = DateFormat('yMd').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Notification"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen1(
                            user: widget.user,
                          )));
            },
          ),
      ),
      body: Center(
        child: Column(children: [
          Flexible(
              flex: 9,
              child: ListView.builder(
                  itemCount: _chatList.length,
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
                                                         "Sender : " +
                                                              _chatList[
                                                                      index]
                                                                  ['sender'],
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
                                                          "Chat : " +
                                                              _chatList[
                                                                      index]
                                                                  ['chat'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blue[600],
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                     
                                                    SizedBox(height: 2),
                                                    Text(""),
                                                  ])
                                            ],
                                          )),
                                             Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            children: [
                                              MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      minWidth: 100,
                      height: 20,
                      child:
                          Text('Reply', style: TextStyle(color: Colors.black)),
                      color: Colors.yellow[600],
                       onPressed: () => {_chat(index)}
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      minWidth: 100,
                      height: 20,
                      child:
                          Text('Delete', style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                       onPressed: () => {_deleteChatDialog(index)}
                    ),
                                            ],
                                          )
                                        ),
                                      )
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
  
 void _chat(int index) {
    Widget setupAlertDialoadContainer() {
      return Container(
        height: 100.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: Column(
        children: [
          Text(
          'Send chat to: ' + _chatList[index]['sender'],
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
        print( _chatList[index]['email']);
        print( widget.user.email);
        http.post(
          Uri.parse("https://crimsonwebs.com/s271738/cemag/php/sendchat.php"),
          body: {
            "sender": widget.user.email,
            "email":  _chatList[index]['sender'],
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
        context, MaterialPageRoute(builder: (content) =>UpdateScreen(user:widget.user)));
      
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
  _loadChat() {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/loadchat.php"),
        body: {"email": widget.user.email}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "No item";
        _chatList = [];
        return;
      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);
        _chatList = jsondata["chat"];
        _titlecenter = "";
      }
      setState(() {});
    });
  }
  void _deleteChat(int index) {
    String id = _chatList[index]['id'];
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/deletechat.php"),
        body: {
          "id": id,
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (content) =>
                    UpdateScreen( user: widget.user)));
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
  void _deleteChatDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Are you sure you want to delete?',
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
                      _deleteChat(index);
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

}
