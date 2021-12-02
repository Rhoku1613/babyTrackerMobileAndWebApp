import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class VaccinationLogBarChart extends StatefulWidget{
  VaccinationLogBarChart({Key? key, required this.data}): super(key: key);
  final List<Vaccine> data;
  @override
  State<VaccinationLogBarChart> createState() => _VaccinationLogBarChartState();
}

class _VaccinationLogBarChartState extends State<VaccinationLogBarChart> {


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
                child: SfSparkBarChart.custom(
                  xValueMapper: (int index) => data[index].name,
                  yValueMapper: (int index) => data[index].numberOfDosesTaken,
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