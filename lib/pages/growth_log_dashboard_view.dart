import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'growth_logs_chart/growth_log_list.dart';
import 'growth_logs_chart/growth_logs_bar_chart.dart';
import 'growth_logs_chart/growth_logs_line_chart.dart';

class GrowthLogDashboardView extends StatefulWidget {
  GrowthLogDashboardView({Key? key, required this.child}): super(key: key);

  final Child child;

  @override
  _GrowthLogDashboardView createState() => _GrowthLogDashboardView();
}

class _GrowthLogDashboardView extends State<GrowthLogDashboardView> {

  List<GrowthLogs> data=[];

  void _populateData() async {;
    ActivityLogService().get_all_growth_logs(this.widget.child.id).then((all_sleep_logs) => {
      setState(() => {data = all_sleep_logs})
    });
  }


  Future<void> _navigateToBarGraph() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => GrowthLogBarChart()));
  }

  Future<void> _navigateToLineChart() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => GrowthLogLineChart(data: this.data,)));
  }

  Future<void> _navigateToPieChart() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => GrowthLogLineChart(data: this.data,)));
  }

  Future<void> _navigateToLogList() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => GrowthLogsListView(data: this.data,)));
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
          }else if(title=="Pie Chart"){
            _navigateToPieChart();
          }else if(title=="Growth Log List"){
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
            title: const Text("Growth Log Dashboard")
        ),
        body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: [
            gridTileFactory("Growth Log List", AssetImage("assets/dashboard/babyTracker-list.png")),
            gridTileFactory("Line Chart",AssetImage("assets/dashboard/babyTracker-line-chart.png")),
            gridTileFactory("Bar Graph",AssetImage("assets/dashboard/babyTracker-bar.png")),
          ],
        ));
  }
}
