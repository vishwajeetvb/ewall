import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'models/TotalSpendingData.dart';

class TotalSpending extends StatefulWidget {
  const TotalSpending({Key key}) : super(key: key);

  @override
  _TotalSpendingState createState() => _TotalSpendingState();
}

class _TotalSpendingState extends State<TotalSpending> {

  List<TotalSpendingData> data = [
    TotalSpendingData('Jan',500),
    TotalSpendingData('Feb',600),
    TotalSpendingData('March',800)
  ];

  Card myChart1Items(){
    return Card(
      color: Colors.orange,
      child: Column(
                children: [
              //Initialize the chart widget
              SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Half yearly sales analysis'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<TotalSpendingData, String>>[
                    LineSeries<TotalSpendingData, String>(
                        dataSource: data,
                        xValueMapper: (TotalSpendingData date, _) => date.date,
                        yValueMapper: (TotalSpendingData date, _) => date.totalAmount,
                        name: 'Sales',
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
                  Text("Your Date-Wise Expense"),
                  SizedBox(height: 10,),
                  Container(
                    color: Colors.purple,
                    height: 310,
                    child: myChart1Items(),
                  ),
                ]
            )
            ]
      )
      ),
    );
  }
}
