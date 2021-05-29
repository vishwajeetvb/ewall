import 'package:ewall/screens/appScreen/cryptoScreen/cryptoDashboard.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/expense_dashboard.dart';
import 'package:ewall/screens/appScreen/uploadTransactions/upload_transactions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home/home_page.dart';

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
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Homepage()))},
          ),
          ListTile(
            leading: Icon(Icons.upload_file),
            title: Text('Upload Transactions'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UploadTransactions()))},
          ),
          ListTile(
            leading: Icon(Icons.upload_file),
            title: Text('Crypto Dashboard'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CryptoDashBoard()))},
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_sharp),
            title: Text('Expense Dashboard'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ExpenseManagement()))},
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
