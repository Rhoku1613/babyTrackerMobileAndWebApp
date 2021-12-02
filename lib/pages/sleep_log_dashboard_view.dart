import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/pages/sleep_logs_chart/sleep_log_bar_chart.dart';
import 'package:baby_tracker/pages/sleep_logs_chart/sleep_log_line_chart.dart';
import 'package:baby_tracker/pages/sleep_logs_chart/sleeping_log_list.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SleepLogDashboardView extends StatefulWidget {
  SleepLogDashboardView({Key? key, required this.child}): super(key: key);

  final Child child;

  @override
  _SleepLogDashboardView createState() => _SleepLogDashboardView();
}

class _SleepLogDashboardView extends State<SleepLogDashboardView> {

  Future<void> _navigateToBarGraph() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => SleepLogBarChart(data: this.data,)));
  }

  Future<void> _navigateToLineChart() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => SleepLogLineChart()));
  }

  Future<void> _navigateToSleepLogList() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => SleepLogsListView()));
  }

  List<SleepLogs> data=[];

  void _populateData() async {
    ActivityLogService().get_all_sleep_logs(this.widget.child.id).then((all_sleep_logs) => {
      setState(() => {data = all_sleep_logs})
    });
  }


  GridTile gridTileFactory(String title, AssetImage assetImage) {
    return GridTile(
      footer: Text(title),
      child: GestureDetector(
        onTap: () {
          if (title == "Bar Graph") {
            _navigateToBarGraph();
          } else if (title == "Line Chart") {
            _navigateToLineChart();
          }else if(title=="Sleep Log List"){
            _navigateToSleepLogList();
          }
        },
        child: Image(
          image: assetImage,
        ),
      ),
    );
  }

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {},
  );




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Sleep Logs")
         ),
        body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: [
            gridTileFactory("Sleep Log List", AssetImage("assets/dashboard/babyTracker-list.png")),
            //gridTileFactory("Line Chart",AssetImage("assets/dashboard/babyTracker-line-chart.png")),
            gridTileFactory("Bar Graph",AssetImage("assets/dashboard/babyTracker-bar.png")),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    _populateData();
  }
}
