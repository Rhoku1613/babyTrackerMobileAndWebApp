import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/blog_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VaccinationLogBarChart extends StatefulWidget{
  VaccinationLogBarChart({Key? key, required this.data}): super(key: key);
  final List<Vaccine> data;
  @override
  State<VaccinationLogBarChart> createState() => _VaccinationLogBarChartState();
}

class _VaccinationLogBarChartState extends State<VaccinationLogBarChart> {
  TooltipBehavior _tooltip = TooltipBehavior(enable: true);
  List<SalesData> data = [
    SalesData('Jan', 35),
  ];

  @override
  Widget build(BuildContext context) {
    List<Vaccine> data = this.widget.data;
    return Scaffold(
        appBar: AppBar(
            title:Text("Vaccination Log Bar Chart")
        ),
        body: Center(
          child: Column(children: [
            //Initialize the chart widget
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //Initialize the spark charts widget
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                    tooltipBehavior: _tooltip,
                    series: <ChartSeries<SalesData, String>>[
                      BarSeries<SalesData, String>(
                          dataSource: this.data,
                          xValueMapper: (SalesData data, _) => data.year,
                          yValueMapper: (SalesData data, _) => data.sales,
                          name: 'Gold',
                          color: Color.fromRGBO(8, 142, 255, 1))
                    ]
              ),
            ))
          ]),
        )
    );
  }
}