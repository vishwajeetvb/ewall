import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class RadialChart extends StatefulWidget {
  final String title;
  final double value;
  const RadialChart({Key key, this.title,this.value}) : super(key: key);

  @override
  _RadialChartState createState() => _RadialChartState();
}

class _RadialChartState extends State<RadialChart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.white,
      child: Column(children: [
        //Initialize the chart widget
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(minimum: 0, maximum: 100,
                ranges: <GaugeRange>[
                GaugeRange(startValue: 0,endValue: 50,color: Colors.green,startWidth: 10,endWidth:10),
                GaugeRange(startValue: 50,endValue: 80,color: Colors.orange,startWidth: 10,endWidth: 10),
                GaugeRange(startValue: 80,endValue: 100,color: Colors.red,startWidth: 10,endWidth: 10)],
                pointers: <GaugePointer>[NeedlePointer(value:widget.value)]
            ),

          ],
          title: GaugeTitle(
              text: widget.title,
              textStyle:
                  TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        )
      ]),
    );
  }
}
