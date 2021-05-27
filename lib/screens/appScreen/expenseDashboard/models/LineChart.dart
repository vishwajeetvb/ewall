import 'package:ewall/screens/appScreen/expenseDashboard/classes/SpendingData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatefulWidget {
  final  List<SpendingData> data;
  LineChart({Key key, this.data}) : super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {

  ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      child: Column(
          children: [
            //Initialize the chart widget
            SfCartesianChart(
                primaryXAxis: DateTimeAxis(
                    desiredIntervals: 3
                ),
                zoomPanBehavior: _zoomPanBehavior,
                // Chart title
                title: ChartTitle(text: 'Your Total Spending Graph'),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),

                series: <ChartSeries>[
                  LineSeries<SpendingData,DateTime>(
                      width: 2,
                      dataSource: widget.data,
                      xValueMapper: (SpendingData data, _) => data.date,
                      yValueMapper: (SpendingData data, _) => data.totalAmount,
                      dataLabelSettings: DataLabelSettings(isVisible: true)
                  )
                ]
            ),
          ]
      ),
    );
  }
}