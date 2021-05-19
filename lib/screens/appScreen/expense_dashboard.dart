
import 'dart:ui';

import 'package:ewall/screens/appScreen/sideMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

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

class _ExpenseDashBoardState extends State<ExpenseDashBoard> {

  var data = [1000.00,200.00,1500.00,989.00,650.00,869.00,1425.00,2589.00,3654.00,1254.00,1145.00,1299.00];

  Material myChart1Items(String title,String priceVal,String subtitle){
    return Material(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(1.0),
                    child: Text(title,style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent
                    ),),
                  ),
                  Padding(padding: EdgeInsets.all(1.0),
                    child: Text(priceVal,style: TextStyle(
                        fontSize: 30.0
                    ),),
                  ),
                  Padding(padding: EdgeInsets.all(1.0),
                    child: Text(subtitle,style: TextStyle(
                        fontSize: 20.0,
                      color: Colors.blueGrey
                    ),),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Sparkline(
                      data:data,
                      fillMode: FillMode.below,
                      fillGradient: new LinearGradient(colors: [Colors.amber[800], Colors.amber[200]]),
                      lineColor: Colors.redAccent,
                      pointsMode: PointsMode.all,
                      pointSize: 8.0,
                    ),
                  )



                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: SideDrawer(),
       appBar: AppBar(
         title: Text('Expense Dashboard'),
       ),
      body: myChart1Items('Total Spending', '5896', '+8.9% Over Spending'),
    );
  }
}
