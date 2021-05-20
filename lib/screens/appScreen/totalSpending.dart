import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class TotalSpending extends StatefulWidget {
  const TotalSpending({Key key}) : super(key: key);

  @override
  _TotalSpendingState createState() => _TotalSpendingState();
}

class _TotalSpendingState extends State<TotalSpending> {

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
    return Scaffold(
      body: Container(
        child: Column(
          children : [
            Column(
              children: [
                Container(
                child: Text('Hello'),
              )]
            ),
            SizedBox(height: 10,),
            Column(
                children: [
                  Text('Graph')
                ]
            ),
            SizedBox(height: 25,),
            Column(
                children : [
                  Container(
                    child: myChart1Items('My Total Spending', '1000', '%15 Over'),
                  ),
                ]
            )
            ]
      )
      ),
    );
  }
}
