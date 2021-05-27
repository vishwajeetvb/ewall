
import 'dart:ui';

import 'package:ewall/screens/appScreen/expenseDashboard/models/assetsSpending.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/models/liabilitiesSpending.dart';
import 'package:ewall/screens/appScreen/sideMenu.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/models/totalSpending.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ExpenseManagement extends StatelessWidget {
  const ExpenseManagement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: ExpenseDashBoard(title: 'Expense DashBoard'),
      theme: ThemeData(
        primaryColor: Colors.orange
      ),
    );
  }
}


class ExpenseDashBoard extends StatefulWidget {
  ExpenseDashBoard({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ExpenseDashBoardState createState() => _ExpenseDashBoardState();
}

class _ExpenseDashBoardState extends State<ExpenseDashBoard> with TickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: SideDrawer(),
       appBar: AppBar(
         title: Text('Expense Dashboard'),
       ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[
              Tab(
                child :Text('Spending',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800
                ),
                ),
              ),
              Tab(
                child :Text('Assets',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800
                ),),
              ),
              Tab(
                child :Text('Liabilities',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800
                ),),
              ),
            ]),
      ),
      body: TabBarView(
        children: <Widget>[
          TotalSpending(),
          AssetsSpending(),
          LiabilitiesSpending(),
        ],
        controller: _tabController,
      ),
    );
  }
}
