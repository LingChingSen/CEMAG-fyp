import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_cemag/view/mainscreen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/user.dart';
import 'package:progress_dialog/progress_dialog.dart';

class MissionScreen extends StatefulWidget {
  final User user;
  const MissionScreen({Key key, this.user}) : super(key: key);

  @override
  _MissionScreenState createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  List _missionList = [];
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');
  int cartitem = 0;
  String _titlecenter = "";
  TextEditingController _chatController = new TextEditingController();
  ProgressDialog pr;
  int _totaltoken = 0;
  int _token = 0;
  int _exp = 0;
  int _totaljelly = 0;
  int _totalexp = 0;
  int _totallevel = 0;
  int _jellybeans = 0;
  int _jellybean = 0;
  int token = 0;
  int jellybeans = 0;
  int _missionjelly = 0;
  int level = 0;
  int _level = 0;
  int exp = 0;
  final now = new DateTime.now();

  @override
  void initState() {
    super.initState();
    _testasync();
    _updateToken();
    _updateJellybeans();
    _updateLevel();
    _updateExp();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final now = new DateTime.now();
    String _date = DateFormat('yMd').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("Mission"),
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
                  itemCount: _missionList.length,
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
                                                          "Mission : " +
                                                              _missionList[
                                                                      index]
                                                                  ['mission'],
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
                                                          "Token : " +
                                                              _missionList[
                                                                      index]
                                                                  ['token'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .yellow[600],
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
                                                              _missionList[
                                                                      index]
                                                                  ['jellybean'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .yellow[600],
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
                                                          "Experience : " +
                                                              _missionList[
                                                                  index]['exp'],
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
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 10, 0),
                                            alignment: Alignment.centerRight,
                                            child: Column(
                                              children: [
                                                MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    minWidth: 100,
                                                    height: 20,
                                                    child: Text('Complete',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black,fontSize: 10,)),
                                                    color: Colors.yellow,
                                                    onPressed: () => {
                                                          _completeDialog(index)
                                                        }),
                                              ],
                                            )),
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

  Future<void> _testasync() async {
    _loadMission("");
  }

  _loadMission(String nothing) {
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/loadmission.php"),
        body: {"email": nothing}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "No item";
        _missionList = [];
        return;
      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);
        _missionList = jsondata["mission"];
        _titlecenter = "";
      }
      setState(() {});
    });
  }

  _checkmission(int index) {
    String id = _missionList[index]['id'];
    if (id == "1") {
  _checkJellybean(index);

    } else if (id == "2") {
      _checkMission3(index);
    } else if (id == "3") {
      _checkMission2(index);
    } else if (id == "4") {
      _checkMission1(index);
    } else if (id == "5") {
      _checkJellybean(index);
    }
  }
   _checkJellybean(index){
 _updateJellybeans();
    String jelly = _missionList[index]['req'];
    _jellybean = int.parse(jellybeans.toString());
    if (_jellybean < int.parse(jelly) ) {
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
                builder: (context) =>MissionScreen(user: widget.user)));
        
      } else{
   _mission15Calculator(index);
      _totalTokenCalculator(index);
      _newStatus();
      _missionJellybeans();
       _totalExpCalculator(index);
        _newExp();
        _totalLevelCalculator1(index);
        _newLevel();

         Fluttertoast.showToast(
            msg: "Mission Complete",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0);
      
      
    
      }
  
   }

  _checkMission1(int index) {
    String _date = DateFormat('yyyy/MM/dd').format(now);
    print(widget.user.email);
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/mission1.php"),
        body: {"email": widget.user.email, "date": _date}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        Fluttertoast.showToast(
            msg: "Please complete the mission!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20.0);
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Mission Complete",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0);
        _totalTokenCalculator(index);
        _totalJellyCalculator(index);
        _newStatus();
        _newJellybeans();
         _totalExpCalculator(index);
        _newExp();
        _totalLevelCalculator1(index);
        
        _newLevel();
      }

      setState(() {});
    });
  }

  _complete1(int index) {
    String id = _missionList[index]['id'];
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/complete1.php"),
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
                builder: (content) => MissionScreen(user: widget.user)));
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

  _checkMission2(int index) {
    String _date = DateFormat('yyyy/MM/dd').format(now);
    print(widget.user.email);
    print(_date);
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/mission2.php"),
        body: {"email": widget.user.email, "date": _date}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        Fluttertoast.showToast(
            msg: "Please complete the mission!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20.0);
        return;
      } else {
         Fluttertoast.showToast(
            msg: "Mission Complete",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0);
        _totalTokenCalculator(index);
        _totalJellyCalculator(index);
        _newStatus();
        _newJellybeans();
         _totalExpCalculator(index);
        _newExp();
        _totalLevelCalculator1(index);
          
        _newLevel();
        
      }

      setState(() {});
    });
  }

  _checkMission3(int index) {
    String _date = DateFormat('yyyy/MM/dd').format(now);
    print(_date);
    print(widget.user.email);
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/mission3.php"),
        body: {"email": widget.user.email, "date": _date}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        Fluttertoast.showToast(
            msg: "Please complete the mission!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20.0);
        return;
      } else {
         Fluttertoast.showToast(
            msg: "Mission Complete",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0);
        _totalTokenCalculator(index);
        _totalJellyCalculator(index);
        _newStatus();
        _newJellybeans();
        _totalExpCalculator(index);
        _newExp();
        _totalLevelCalculator1(index);
    
        _newLevel();
      }

      setState(() {});
    });
  }

  void _completeDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Are you sure you have completed?',
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
                      _checkmission(index);
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
     _updateJellybeans();
    String qty = _missionList[index]['jellybean'];
    _jellybeans = int.parse(jellybeans.toString());
    _totaljelly = _jellybeans + int.parse(qty);
  }

  _totalTokenCalculator(index) {
    _updateToken();
    String token2 = _missionList[index]['token'];
    _token = int.parse(token.toString());
    _totaltoken = _token + int.parse(token2);
    print(_token);
  }

    _totalExpCalculator(index) {
      _updateExp();
    String exp2 = _missionList[index]['exp'];
    _exp = int.parse(exp.toString());
    _totalexp = _exp + int.parse(exp2);
    
  }

      _totalLevelCalculator1(index) {
         _updateExp();
        _updateLevel();
        _exp = exp;
         _level = int.parse(level.toString());
      if (_level == 1){
         
           if (_exp > 1000) {

          _totallevel = _level + 1;
       
           } else  {
           _totallevel = _level ;
        }

      }else if (_level == 2){
         
           if (_exp > 2000) {

          _totallevel = _level + 1;
       
           } else  {
           _totallevel = _level ;
        }

      }else if (_level == 3){
         
           if (_exp > 2200) {

          _totallevel = _level + 1;
       
           } else  {
           _totallevel = _level ;
        }

      }else if (_level == 4){
         
           if (_exp > 2500) {

          _totallevel = _level + 1;
       
           } else  {
           _totallevel = _level ;
        }

      }
    print(_totallevel);
  }

   

  _mission15Calculator(index) {
     _updateJellybeans();
    String jelly = _missionList[index]['req'];
    _jellybean = int.parse(jellybeans.toString());
    _missionjelly = _jellybean - int.parse(jelly);
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

  void _updateExp() {
    print(widget.user.email);
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s271738/cemag/php/printexp.php"),
        body: {"email": widget.user.email}).then((response) {
      setState(() {
        exp = int.parse(response.body);
        print(exp);
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

  Future<void> _newLevel() async {
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/updatelevel.php"),
        body: {
          "level": _totallevel.toString(),
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

  Future<void> _newExp() async {
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/updateexp.php"),
        body: {
          "exp": _totalexp.toString(),
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

  Future<void> _missionJellybeans() async {
    http.post(
        Uri.parse("https://crimsonwebs.com/s271738/cemag/php/missionjelly.php"),
        body: {
          "jelly": _missionjelly.toString(),
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
