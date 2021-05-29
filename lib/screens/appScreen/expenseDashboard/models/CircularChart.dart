
import 'package:ewall/screens/appScreen/expenseDashboard/classes/SpendingData.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/classes/circularData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../classes/categoriesData.dart';

class CircularChart extends StatefulWidget {
  List<CircularData> data;
  CircularChart({Key key,this.data}) : super(key: key);

  @override
  _CircularChartState createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {


  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.white,
      child: Column(
          children: [
            //Initialize the chart widget
            SfCircularChart(
              legend: Legend(isVisible: true),
                series: <CircularSeries>[
                  // Render pie chart
                  PieSeries<CircularData, String>(
                      dataSource: widget.data,
                      pointColorMapper:(CircularData data,  _) => data.color,
                      xValueMapper: (CircularData data, _) => data.TransactionName,
                      yValueMapper: (CircularData data, _) => data.amount,
                    radius: '80%',
                    explode: true,
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.inside
                    )
                  )
                ]
            )

          ]
      ),
    );
  }
}
