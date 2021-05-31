import '../classes/SpendingData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'LineChart.dart';

class LiabilitiesSpending extends StatefulWidget {
  final String uid;
  const LiabilitiesSpending({Key key,this.uid}) : super(key: key);

  @override
  _LiabilitiesSpendingState createState() => _LiabilitiesSpendingState();
}

class _LiabilitiesSpendingState extends State<LiabilitiesSpending> {

  List<LinearChartData> liabilitiesdata = [];


  @override
  void initState() {
    super.initState();
    getTSGraphData();
  }

  void getTSGraphData(){
    var collectionReference = FirebaseFirestore.instance.collection("Users").doc(widget.uid)
        .collection('Transaction').orderBy('TransactionDate');
    var query = collectionReference.where('TransactionClass',isEqualTo:"Liabilities");
    query.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        LinearChartData tsd = LinearChartData(
            DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch)
            ,element['TransactionAmount'].toDouble()
        );
        setState(() {
          liabilitiesdata.add(tsd);
        });
        print("Total Liabilities Data");
        print(DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch).toString()
            +element['TransactionAmount'].toDouble().toString());
      }
      );


    });

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
                      Text("This is Your Liabilities Spending Data",style: TextStyle(
                        fontSize: 18
                      ),),
                      SizedBox(height: 20,),
                      Container(
                        height: 310,
                        child: LineChart(data: liabilitiesdata),
                      ),
                    ]
                )
              ]
          )
      ),
    );
  }
}

