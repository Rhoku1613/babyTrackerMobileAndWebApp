import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/blog_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SleepLogBarChart extends StatefulWidget{
  SleepLogBarChart({Key? key, required this.data}): super(key: key);
  final List<SleepLogs> data;
  @override
  State<SleepLogBarChart> createState() => _SleepLogBarChartState();
}

class _SleepLogBarChartState extends State<SleepLogBarChart> {
  List<SleepData> sleepData=[];

  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltip = TooltipBehavior(enable: true);

    List<SalesData> data = [
      SalesData('Jan', 35),
      SalesData('Feb', 35)
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
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(minimum: 0, maximum: 10, interval: 1),
                    tooltipBehavior: _tooltip,
                    series: <ChartSeries<SleepData, String>>[
                      BarSeries<SleepData, String>(
                          dataSource: this.sleepData,
                          xValueMapper: (SleepData data, _) => data.date,
                          yValueMapper: (SleepData data, _) => data.hours,
                          name: "Sleep Hours",
                          color: Color.fromRGBO(8, 142, 255, 1))
                    ]
                ),
              ),
            )
          ]),
        )
    );
  }

  @override
  void initState() {
    super.initState();
    _cleanAndProcessData();
  }

  void _cleanAndProcessData() {
    List<SleepData> sleepDataList=[];

    for(SleepLogs sleeplog in this.widget.data){
      String startDateTime=sleeplog.date+" "+sleeplog.start;
      String endDateTime=sleeplog.date+" "+sleeplog.end;
      var startDateTimeParsed = DateTime.parse(startDateTime);
      var endDateTimeParsed=DateTime.parse(endDateTime);
      final difference=endDateTimeParsed.difference(startDateTimeParsed).inHours;
      SleepData sleepData=SleepData(sleeplog.date,difference);
      sleepDataList.add(sleepData);
    }


    setState(() {
      this.sleepData=sleepDataList;
    });
  }
}