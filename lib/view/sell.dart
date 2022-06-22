import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_cemag/view/mainscreen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/user.dart';
import 'package:fyp_cemag/view/addSell.dart';


class SellScreen extends StatefulWidget {
  final User user;
  const SellScreen({Key key, this.user}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  List _productList = [];
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');
  int cartitem = 0;
  String _titlecenter = "";

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final now = new DateTime.now();
    String _date = DateFormat('yMd').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sell"),
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
                                                         "Seller : " +
                                                              _productList[
                                                                      index]
                                                                  ['email'],
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: TextStyle(
                                                            color: Colors
                                                                  .pink[600],
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
                                                          "Description : " +
                                                              _productList[
                                                                      index]
                                                                  ['description'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .green[600],
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
                                                          "Total sales : " +
                                                              _productList[
                                                                      index]
                                                                  ['total']+ " tokens",
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
                                        flex: 2,
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          alignment: Alignment.centerRight,
                                          child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      minWidth: 100,
                      height: 20,
                      child:
                          Text('Delete', style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                       onPressed: () => {_deleteSellDialog(index)}
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewSales(user: widget.user)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  void _deleteSell(int index) {
    String id = _productList[index]['id'];
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/deletesell.php"),
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
                    SellScreen( user: widget.user)));
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
  void _deleteSellDialog(int index) {
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
                      _deleteSell(index);
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

  _loadPost() {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/loadsales.php"),
        body: {"email": widget.user.email}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "No item";
        _productList = [];
        return;
      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);
        _productList = jsondata["post"];
        _titlecenter = "";
      }
      setState(() {});
    });
  }
}
