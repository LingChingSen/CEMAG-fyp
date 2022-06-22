import 'package:fyp_cemag/view/about.dart';
import 'package:fyp_cemag/view/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:fyp_cemag/view/user.dart';
import 'package:fyp_cemag/view/myprofile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class MyDrawer extends StatefulWidget {
  final User user;

  const MyDrawer({Key key, this.user}) : super(key: key);
  @override
  _MyDrawerState createState() => _MyDrawerState();

}
 

class _MyDrawerState extends State<MyDrawer> {
  int token = 0;
  int jellybeans= 0;
  int level= 0;

  @override
  void initState() {
    super.initState();
   _updateToken();
   _updateJellybeans();
   _updateLevel();

   
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountEmail: Text(widget.user.email),
          currentAccountPicture: CircleAvatar(
            backgroundColor:
                Theme.of(context).platform == TargetPlatform.android
                    ? Colors.white
                    : Colors.red,
            backgroundImage: AssetImage(
              "assets/images/user.png",
            ),
          ),
          accountName: Text(widget.user.name),
          
        ),
        
        Container(
          margin: EdgeInsets.all(2),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(17, 5, 20, 5),
                     child: Column(
                        children: [
        Row(
                          children: [
                            Expanded(flex: 3, child: Text("Level:")),
                            Container(
                                height: 20,
                                child: VerticalDivider(color: Colors.grey)),
                            Expanded(
                              flex: 7,
                              child: Text(level.toString(),),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(flex: 3, child: Text("Token:")),
                            Container(
                                height: 20,
                                child: VerticalDivider(color: Colors.grey)),
                            Expanded(flex: 7, child: Text(token.toString(),)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(flex: 3, child: Text("Jellybeans:")),
                            Container(
                                height: 20,
                                child: VerticalDivider(color: Colors.grey)),
                            Expanded(
                                flex: 7, child: Text(jellybeans.toString(),)),
                          ],
                        ),
                        ]))),
                 Divider(
                  color: Colors.grey,
                  height: 2,
                ),
        ListTile(
            title: Text("My Profile"),
            trailing: Icon(Icons.account_circle_rounded),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyProfile(user: widget.user)));
            }),
        ListTile(
            title: Text("Customer Service"),
            trailing: Icon(Icons.chat_outlined),
            onTap: () {
              launchWhatsapp(
                  number: "+60172828151", message: "Hi CEMAG! I am");
            }),
        ListTile(
            title: Text("About Us"),
            trailing: Icon(Icons.assignment_ind_rounded),
            onTap: () { Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AboutScreen(user: widget.user)));
              
            }),
        
        ListTile(
            title: Text("Logout"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              _logoutDialog();
            })
      ],
    ));
  }

  void launchWhatsapp({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";
    await canLaunch(url) ? launch(url) : print("Can't open Whatsapp");
  }

  void _logoutDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Are you sure to logout?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes",
                        style: TextStyle(color: Colors.yellow[600])),
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
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
