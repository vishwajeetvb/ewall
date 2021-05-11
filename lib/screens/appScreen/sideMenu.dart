import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home/HomePage.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {

  void _logout() async{
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'TransManager',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_sharp),
            title: Text('Expense Manager'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => homePage()))},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {_logout()},
          ),
        ],
      ),
    );
  }
}
