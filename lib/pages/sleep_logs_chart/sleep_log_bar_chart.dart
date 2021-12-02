import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SleepLogBarChart extends StatefulWidget{
  SleepLogBarChart({Key? key, required this.data}): super(key: key);

  final List<SleepLogs> data;

  @override
  State<SleepLogBarChart> createState() => _SleepLogBarChartState();
}

class _SleepLogBarChartState extends State<SleepLogBarChart> {
  @override
  Widget build(BuildContext context) {
    List<SleepLogs> data = this.widget.data;
    return Scaffold(
        appBar: AppBar(
          title:Text("Sleep Log Bar Chart")
        ),
        body: Center(
          child: Column(children: [
            //Initialize the chart widget
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //Initialize the spark charts widget
                child: SfSparkBarChart.custom(
                  xValueMapper: (int index) => data[index].date,
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