import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DiaperChangeLogBarChart extends StatefulWidget{
  DiaperChangeLogBarChart({Key? key, required this.data}): super(key: key);

  final List<DiaperChangeLogs> data;

  @override
  State<DiaperChangeLogBarChart> createState() => _DiaperChangeLogBarChartState();
}

class _DiaperChangeLogBarChartState extends State<DiaperChangeLogBarChart> {
  @override
  Widget build(BuildContext context) {
    List<DiaperChangeLogs> data = this.widget.data;
    return Scaffold(
        appBar: AppBar(
            title:Text("Diaper Change Log Bar Chart")
        ),
        body: Center(
          child: Column(children: [
            //Initialize the chart widget
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //Initialize the spark charts widget
                child: SfSparkBarChart.custom(
                  xValueMapper: (int index) => data[index].datetime,
                  yValueMapper: (int index) => data[index].child,
                  dataCount: 5,
                  labelDisplayMode: SparkChartLabelDisplayMode.all,
                  trackball: SparkChartTrackball(
                      activationMode: SparkChartActivationMode.tap),
                ),
              ),
            )
          ]),
        )
    );
  }
}