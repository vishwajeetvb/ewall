
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../classes/categoriesData.dart';

class CircularChart extends StatefulWidget {
  const CircularChart({Key key}) : super(key: key);

  @override
  _CircularChartState createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {

  List<ChartData> chartData = [
    ChartData('David', 25),
    ChartData('Steve', 38),
    ChartData('Jack', 34),
    ChartData('Others', 52)
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      child: Column(
          children: [
            //Initialize the chart widget
            SfCircularChart(
              legend: Legend(isVisible: true),
                series: <CircularSeries>[
                  // Render pie chart
                  PieSeries<ChartData, String>(
                      dataSource: chartData,
                      pointColorMapper:(ChartData data,  _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
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
