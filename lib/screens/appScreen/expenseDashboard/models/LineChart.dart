import 'package:ewall/screens/appScreen/expenseDashboard/classes/SpendingData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatefulWidget {
  final  List<LinearChartData> data;
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
      //00color: Colors.white,
      child: Column(
          children: [
            //Initialize the chart widget
            SfCartesianChart(
                primaryXAxis: DateTimeAxis(
                    desiredIntervals: 3
                ),
                zoomPanBehavior: _zoomPanBehavior,
                // Chart title
                title: ChartTitle(text: 'Spending Graph'),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),

                series: <ChartSeries>[
                  SplineSeries<LinearChartData,DateTime>(
                      dataSource: widget.data,
                      splineType: SplineType.cardinal,
                      cardinalSplineTension: 0.5,
                      xValueMapper: (LinearChartData data, _) => data.date,
                      yValueMapper: (LinearChartData data, _) => data.totalAmount,
                      markerSettings: MarkerSettings(isVisible: true)
                  )
                ]
            ),
          ]
      ),
    );
  }
}
