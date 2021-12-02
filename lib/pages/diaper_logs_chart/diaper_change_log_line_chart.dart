import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/blog_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DiaperChangeLogLineChart extends StatefulWidget{

  DiaperChangeLogLineChart({Key? key, required this.data}): super(key: key);

  final List<DiaperChangeLogs> data;

  @override
  State<DiaperChangeLogLineChart> createState() => _DiaperChangeLogLineChartState();
}

class _DiaperChangeLogLineChartState extends State<DiaperChangeLogLineChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:Text("Diaper Change Log Line Chart")
        ),
        body: Center(
          child: Column(children: [
            //Initialize the chart widget
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Sleep Log Pattern'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<DiaperChangeLogs, String>>[
                  LineSeries<DiaperChangeLogs, String>(
                      dataSource: this.widget.data,
                      xValueMapper: (DiaperChangeLogs sales, _) => sales.datetime,
                      yValueMapper: (DiaperChangeLogs sales, _) => sales.child,
                      name: 'Sales',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
          ]),
        )
    );
  }
}