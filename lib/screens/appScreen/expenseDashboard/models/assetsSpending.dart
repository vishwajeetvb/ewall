
import 'package:ewall/screens/appScreen/expenseDashboard/models/LineChart.dart';

import '../classes/SpendingData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssetsSpending extends StatefulWidget {
  final String uid;
  const AssetsSpending({Key key,this.uid}) : super(key: key);

  @override
  _AssetsSpendingState createState() => _AssetsSpendingState();
}

class _AssetsSpendingState extends State<AssetsSpending> {

  List<LinearChartData> assetdata = [];
  ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    getTSGraphData();
  }

  void getTSGraphData(){
    var collectionReference = FirebaseFirestore.instance.collection("Users").doc(widget.uid).
    collection('Transaction').orderBy('TransactionDate');
    var query = collectionReference.where('TransactionClass',isEqualTo:"Assets");
    query.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        LinearChartData tsd = LinearChartData(
            DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch)
            ,element['TransactionAmount'].toDouble()
        );
        setState(() {
          assetdata.add(tsd);
        });
        print("Total Assets Data");
        print(DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch).toString()
            +element['TransactionAmount'].toDouble().toString());
      }
      );});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
              children : [
                Column(
                    children : [
                      SizedBox(height: 20,),
                      Text("This is Your Asset Spending Data",style: TextStyle(
                        fontSize: 18,
                      ),),
                      SizedBox(height: 20,),
                      Container(
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

