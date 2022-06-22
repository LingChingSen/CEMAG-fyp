import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_cemag/view/mainscreen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/user.dart';
import 'package:fyp_cemag/view/notification.dart';
import 'package:progress_dialog/progress_dialog.dart';



class Update2Screen extends StatefulWidget {
  final User user;
  const Update2Screen({Key key, this.user}) : super(key: key);

  @override
  _Update2ScreenState createState() => _Update2ScreenState();
}

class _Update2ScreenState extends State<Update2Screen> {
  List _productList = [];
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');
  int cartitem = 0;
  String _titlecenter = "";
  TextEditingController _chatController = new TextEditingController();
  ProgressDialog pr;
  int _totaltoken = 0;
  int _token = 0;
  int _totaljelly = 0;
  int _jellybeans = 0;
  int token = 0;
  int jellybeans = 0;


  @override
  void initState() {
    super.initState();
    _loadSold();
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
        title: Text("Update Notification"),
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
                  itemCount: _productList.length,
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
                                                         "Description : Item succesfully sold ! ",
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
                                                          "Buyer : " +
                                                              _productList[
                                                                      index]
                                                                  ['buyer'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .pink[600],
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
                                                          "Jellybeans : " +
                                                              _productList[
                                                                      index]
                                                                  ['quantity'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .orange[600],
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
                                                          "Total : " +
                                                              _productList[
                                                                      index]
                                                                  ['total'] + " tokens",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .orange[600],
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
                          Text('Collect', style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                       onPressed: () => {
                       _checkJellybean(index)}
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
  

  _loadSold() {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/loadsold.php"),
        body: {"email": widget.user.email}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "No item";
        _productList = [];
        return;
      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);
        _productList = jsondata["sold"];
        _titlecenter = "";
      }
      setState(() {});
    });
  }
  void _collect(int index) {
    String id = _productList[index]['id'];
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/collectsales.php"),
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
                    Update2Screen( user: widget.user)));
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
  void _collectSalesDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Are you sure you want to collect?',
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
                      _collect(index);
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
   _totalJellyCalculator(index) {
    String qty = _productList[index]['quantity'];
    _jellybeans = int.parse(jellybeans.toString());
    _totaljelly = _jellybeans - int.parse(qty);
  }
   _totalTokenCalculator(index) {
    String total = _productList[index]['total'];
    _token = int.parse(token.toString());
    _totaltoken = _token + int.parse(total);
  }
   _checkJellybean(index){
 _updateJellybeans();
    String qty = _productList[index]['quantity'];
    _jellybeans = int.parse(jellybeans.toString());
    if (_jellybeans < int.parse(qty) ) {
         Fluttertoast.showToast(
            msg: "Not enough jellybeans!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20.0);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>NotificationScreen1(user: widget.user)));
        
      } else{
_collectSalesDialog(index);

    
      }
  
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


}
