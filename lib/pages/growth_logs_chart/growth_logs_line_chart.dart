import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/blog_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GrowthLogLineChart extends StatefulWidget{
  GrowthLogLineChart({Key? key, required this.data}): super(key: key);

  final List<GrowthLogs> data;

  @override
  State<GrowthLogLineChart> createState() => _GrowthLogLineChartState();
}

class _GrowthLogLineChartState extends State<GrowthLogLineChart> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:Text("Growth Line Chart")
        ),
        body: Center(
          child: Column(children: [
            //Initialize the chart widget
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Growth Pattern'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<GrowthLogs, String>>[
                  LineSeries<GrowthLogs, String>(
                      dataSource: this.widget.data,
                      xValueMapper: (GrowthLogs sales, _) => sales.datetime,
                      yValueMapper: (GrowthLogs sales, _) => sales.height,
                      name: 'Height',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
          ]),
        )
    );
  }
}