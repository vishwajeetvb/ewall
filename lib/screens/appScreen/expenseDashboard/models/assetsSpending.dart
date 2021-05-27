
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

  Card myChartItems(){
    return Card(
      color: Colors.orange,
      child: Column(
          children: [
            //Initialize the chart widget
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Your Total Spending Graph'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries>[
                  LineSeries<SpendingData, DateTime>(
                      name: "TotalSpending",
                      dataSource: assetdata,
                      xValueMapper: (SpendingData data, _) => data.date,
                      yValueMapper: (SpendingData data, _) => data.totalAmount,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
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
                      Text("Your Asset Data"),
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

