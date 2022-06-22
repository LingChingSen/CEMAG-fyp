import 'dart:convert';
import 'dart:io';
import 'package:fyp_cemag/view/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:fyp_cemag/view/mainscreen.dart';

class AddNewSales extends StatefulWidget {
  final User user;
  const AddNewSales({Key key, this.user}) : super(key: key);
  @override
  _AddNewSalesState createState() => _AddNewSalesState();
}

class _AddNewSalesState extends State<AddNewSales> {
  double screenHeight, screenWidth;
  ProgressDialog pr;
  TextEditingController _desController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  int _itemCount = 1;
   int _total = 0;
    int jellybeans = 0;
    int _jellybeans = 0;
    int token = 0;
    int level = 0;
      final now = new DateTime.now();
    @override
  void initState() {
    super.initState();
   _updateJellybeans();
   _updateToken();
   _updateLevel();
  }
  @override
   Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(100, 50, 100, 10),
              child: Image.asset('assets/images/addpost.png', scale: 2),
            ),
            SizedBox(height: 3),
            Text('Add Sales',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Text(widget.user.name),
            Container(
              margin: EdgeInsets.fromLTRB(70, 50, 70, 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Column(children: [
                  TextField(
                    controller: _desController,
                    decoration: InputDecoration(
                        labelText: 'Description', icon: Icon(Icons.note_add)),
                  ),
                  TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                        labelText: 'Tokens to sell', icon: Icon(Icons.money_outlined))
                  ),
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
                    height: 20,
                    child:
                        Text('Post', style: TextStyle(color: Colors.white)),
                    color: Colors.brown,
                    onPressed:() {_checkJellybean();
                     }
                  )
                ]),
              ),
            ),
       
          ],
        ),
      ),
    )
    );
  }

  

  
  void postNewProductDialog() {
   String _description = _desController.text.toString();
    
    String _price = _priceController.text.toString();
    

    if(_description.isEmpty  && _price.isEmpty  ){
      Fluttertoast.showToast(
        msg: "Please fill in all textfield",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }
    else if(_description.isEmpty ){
      Fluttertoast.showToast(
        msg: "Description is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
      return;

    }else if(_price.isEmpty){
      Fluttertoast.showToast(
        msg: "Price is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
      return;
   
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Add New Post???"),
            content: Text("Are your sure?"),
            actions: [
              TextButton(
                child: Text("Ok",style: TextStyle(
                            color: Colors.yellow[600],
                          )),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addNewPost();
                },
              ),
              TextButton(
                  child: Text("Cancel",style: TextStyle(
                            color: Colors.yellow[600],
                          )),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  
  Future<void> _addNewPost() async {
    pr = ProgressDialog(context);
    pr.style(
      message: 'Posting...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
        await pr.show();
        String description = _desController.text.toString();
        String _date = DateFormat('yyyy/MM/dd').format(now);
        print(_date);
        print(widget.user.email);
        
        http.post(
          Uri.parse("https://crimsonwebs.com/s271738/cemag/php/newpost.php"),
          body: {
            "email": widget.user.email,
            "name": widget.user.name,
            "description": description,
            "total": _total.toString(),
            "quantity":_itemCount.toString(),
            "date": _date,
            "level": level.toString(),
            "tokens" : token.toString(),
            "jellybeans" :jellybeans.toString(),
            
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
          _desController.text = "";
          _priceController.text = "";
  
        });
         Navigator.push(
        context, MaterialPageRoute(builder: (content) =>MainScreen(user:widget.user)));
      
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
   _checkJellybean(){
  _updateJellybeans();
  _jellybeans = jellybeans;
    if (_jellybeans < _itemCount ) {
        Fluttertoast.showToast(
            msg:
                "Not enough jellybeans!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddNewSales(user: widget.user)));
        
      } else{
    postNewProductDialog();
      }
  
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
  
_totalCalculatorR(){
  setState(() => _itemCount--);
  String price = _priceController.text.toString();
  _total=0;
    _total = int.tryParse(price)*_itemCount;
    
  }
  _totalCalculatorA(){
  setState(() => _itemCount++);
  String price = _priceController.text.toString();
  _total=0;
    _total = int.tryParse(price)*_itemCount; 
    
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

  

}