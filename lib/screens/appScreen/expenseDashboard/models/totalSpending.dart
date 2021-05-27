
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../classes/SpendingData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class TotalSpending extends StatefulWidget {
  const TotalSpending({Key key}) : super(key: key);

  @override
  _TotalSpendingState createState() => _TotalSpendingState();
}

class _TotalSpendingState extends State<TotalSpending> {

  //Here we make a reference to our collection Transactions
  CollectionReference users = FirebaseFirestore.instance.collection('Transactions');

  List<SpendingData> data = [];


  @override
  void initState() {
    super.initState();
    getTSGraphData();
  }

  void getTSGraphData(){

    var collectionReference = FirebaseFirestore.instance.collection('Transactions').orderBy('TransactionDate');
    collectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        SpendingData tsd = SpendingData(
            DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch)
            ,element['TransactionAmount'].toDouble()
        );
        setState(() {
          data.add(tsd);
        });
        print("Date: "+DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch).toString()
            +" Amount is "+element['TransactionAmount'].toString());
      }
      );});

  }

  Card myChartItems(){
    return Card(
      color: Colors.orange,
      child: Column(
                children: [
              //Initialize the chart widget
              SfCartesianChart(
                  primaryXAxis: DateTimeAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Your Total Spending Graph'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries>[
                    LineSeries<SpendingData,DateTime>(
                        dataSource: data,
                        xValueMapper: (SpendingData data, _) => data.date,
                        yValueMapper: (SpendingData data, _) => data.totalAmount,
                    ),
                  ]
              ),
            ]
      ),
    );


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
                  Text("Your Date-Wise Expense"),
                  SizedBox(height: 10,),
                  Container(
                    color: Colors.purple,
                    height: 310,
                    child: myChartItems(),
                  ),
                ]
            )
            ]
      )
      ),
    );
  }
}
