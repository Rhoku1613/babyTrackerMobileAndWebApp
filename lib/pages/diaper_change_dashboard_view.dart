import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'diaper_logs_chart/diaper_change_log_line_chart.dart';
import 'diaper_logs_chart/diaper_change_log_list_view.dart';
import 'diaper_logs_chart/diaper_log_bar_chart.dart';
import 'growth_logs_chart/growth_log_list.dart';
import 'growth_logs_chart/growth_logs_bar_chart.dart';
import 'growth_logs_chart/growth_logs_line_chart.dart';

class DiaperChangeLogDashboardView extends StatefulWidget {
  DiaperChangeLogDashboardView({Key? key, required this.child}): super(key: key);

  final Child child;

  @override
  _DiaperChangeLogDashboardView createState() => _DiaperChangeLogDashboardView();
}

class _DiaperChangeLogDashboardView extends State<DiaperChangeLogDashboardView> {

  List<DiaperChangeLogs> data=[];

  void _populateData() async {;
  ActivityLogService().get_all_diaper_change_logs(this.widget.child.id).then((all_diaper_logs) => {
    setState(() => {data = all_diaper_logs})
  });
  }
  Future<void> _navigateToLineChart() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => DiaperChangeLogLineChart(data: this.data,)));
  }

  Future<void> _navigateToBarGraph() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => DiaperChangeLogBarChart(data: this.data,)));
  }

  Future<void> _navigateToLogList() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => DiaperChangeLogsListView(data: this.data,)));
  }

  @override
  void initState() {
    super.initState();
    _populateData();
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
          }else if(title=="Diaper Change Log List"){
            _navigateToLogList();
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
            title: const Text("Diaper Change Log Dashboard")
        ),
        body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: [
            gridTileFactory("Diaper Change Log List", AssetImage("assets/dashboard/babyTracker-list.png")),
            gridTileFactory("Line Chart",AssetImage("assets/dashboard/babyTracker-line-chart.png")),
            gridTileFactory("Bar Graph",AssetImage("assets/dashboard/babyTracker-bar.png")),
          ],
        ));
  }
}
