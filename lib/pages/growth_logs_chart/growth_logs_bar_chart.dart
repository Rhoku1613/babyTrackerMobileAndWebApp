import 'package:baby_tracker/models/blog_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GrowthLogBarChart extends StatefulWidget{
  @override
  State<GrowthLogBarChart> createState() => _GrowthLogBarChartState();
}

class _GrowthLogBarChartState extends State<GrowthLogBarChart> {
  @override
  Widget build(BuildContext context) {
    List<SalesData> data = [
      SalesData('Jan', 35),
      SalesData('Feb', 28),
      SalesData('Mar', 34),
      SalesData('Apr', 32),
      SalesData('May', 40)
    ];
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
                  xValueMapper: (int index) => data[index].year,
                  yValueMapper: (int index) => data[index].sales,
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