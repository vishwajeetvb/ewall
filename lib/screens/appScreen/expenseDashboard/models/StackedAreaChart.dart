import 'package:ewall/screens/appScreen/expenseDashboard/classes/AreaChartData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AreaChart extends StatefulWidget {
  final  List<AreaChartData> data;
  AreaChart({Key key, this.data}) : super(key: key);

  @override
  _AreaChartState createState() => _AreaChartState();
}

class _AreaChartState extends State<AreaChart> {

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
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries>[
                  SplineAreaSeries<AreaChartData, DateTime>(
                    color: Colors.red,
                      splineType: SplineType.cardinal,
                      cardinalSplineTension: 0.5,
                      dataSource: widget.data,
                      xValueMapper: (AreaChartData sales, _) => sales.date,
                      yValueMapper: (AreaChartData sales, _) => sales.expenseAmount,
                      markerSettings: MarkerSettings(isVisible: true)
                  ),
                  SplineAreaSeries<AreaChartData, DateTime>(
                      color: Colors.yellow,
                      splineType: SplineType.cardinal,
                      cardinalSplineTension: 0.5,
                      dataSource: widget.data,
                      xValueMapper: (AreaChartData sales, _) => sales.date,
                      yValueMapper: (AreaChartData sales, _) => sales.incomeAmount,
                      markerSettings: MarkerSettings(isVisible: true)
                  ),
                ]
            ),
          ]
      ),
    );
  }
}
