
import 'package:ewall/screens/appScreen/expenseDashboard/models/LineChart.dart';

import '../classes/SpendingData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssetsSpending extends StatefulWidget {
  const AssetsSpending({Key key}) : super(key: key);

  @override
  _AssetsSpendingState createState() => _AssetsSpendingState();
}

class _AssetsSpendingState extends State<AssetsSpending> {

  List<SpendingData> assetdata = [];
  ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    getTSGraphData();
  }

  void getTSGraphData(){
    var collectionReference = FirebaseFirestore.instance.collection('Transactions').orderBy('TransactionDate');
    var query = collectionReference.where('TransactionClass',isEqualTo:"Assets");
    query.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        SpendingData tsd = SpendingData(
            DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch)
            ,element['TransactionAmount'].toDouble()
        );
        setState(() {
          assetdata.add(tsd);
        });
        print("Date: "+DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch).toString()
            +" Amount is "+element['TransactionAmount'].toString());
      }
      );});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
              children : [
                SizedBox(height: 25,),
                Column(
                    children : [
                      Text("Your Asset Data"),
                      SizedBox(height: 10,),
                      Container(
                        color: Colors.purple,
                        height: 310,
                        child: LineChart(data: assetdata,),
                      ),
                    ]
                )
              ]
          )
      ),
    );
  }
  }

