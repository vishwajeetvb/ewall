import 'package:ewall/screens/appScreen/budget/yourBudget.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/expense_dashboard.dart';
import 'package:ewall/screens/appScreen/startingScreen/firstScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home/home_page.dart';

class SideDrawer extends StatefulWidget {
  final User user;
  const SideDrawer({Key key,this.user}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {

  void _logout() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => IntroScreen()),
            (_) => false);
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
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Homepage(user: widget.user,)))},
          ),
          ListTile(
            leading: Icon(Icons.book_outlined),
            title: Text('Create Your Budget'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyBudget(user: widget.user,)))},
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_sharp),
            title: Text('Expense Dashboard'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ExpenseManagement(user: widget.user,)))},
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
