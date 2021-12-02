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
                    primaryYAxis: NumericAxis(minimum: 0, maximum: 10, interval: 1),
                    tooltipBehavior: _tooltip,
                    series: <ChartSeries<Vaccine, String>>[
                      BarSeries<Vaccine, String>(
                          dataSource: this.widget.data,
                          xValueMapper: (Vaccine data, _) => data.name,
                          yValueMapper: (Vaccine data, _) => data.numberOfDoses,
                          yAxisName: "Doses",
                          xAxisName: "Name of Vaccine",
                          name: 'Total Number Of Doses',
                          color: Color.fromRGBO(8, 142, 255, 1)),
                      BarSeries<Vaccine, String>(
                          dataSource: this.widget.data,
                          xValueMapper: (Vaccine data, _) => data.name,
                          yValueMapper: (Vaccine data, _) => data.numberOfDosesTaken,
                          yAxisName: "Doses",
                          xAxisName: "Number Of Doses Taken",
                          name: 'Vaccination',
                          color: Color.fromRGBO(255, 182, 193, 1))
                    ]
              ),
            ))
          ]),
        )
    );
  }
}