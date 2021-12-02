import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/pages/sleep_logs_chart/sleep_log_bar_chart.dart';
import 'package:baby_tracker/pages/sleep_logs_chart/sleep_log_line_chart.dart';
import 'package:baby_tracker/pages/sleep_logs_chart/sleeping_log_list.dart';
import 'package:baby_tracker/pages/vaccination_logs_chart/vaccination_logs_bar_chart.dart';
import 'package:baby_tracker/pages/vaccination_logs_chart/vaccination_logs_line_chart.dart';
import 'package:baby_tracker/pages/vaccination_logs_chart/vaccination_logs_list.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class VaccinationLogDashboardView extends StatefulWidget {
  VaccinationLogDashboardView({Key? key, required this.child}): super(key: key);

  final Child child;

  @override
  _VaccinationLogDashboardView createState() => _VaccinationLogDashboardView();
}

class _VaccinationLogDashboardView extends State<VaccinationLogDashboardView> {

  Future<void> _navigateToBarGraph() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => VaccinationLogBarChart(data: this.data,)));
  }

  Future<void> _navigateToLineChart() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => VaccinationLogLineChart()));
  }

  Future<void> _navigateToSleepLogList() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => VaccinationLogsListView(data: this.data,)));
  }

  List<Vaccine> data=[];

  void _populateData() async {
    ActivityLogService().get_all_vaccine_logs(this.widget.child.id).then((all_vaccine_logs) => {
      setState(() => {data = all_vaccine_logs})
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
            title: const Text("Vaccination Logs")
        ),
        body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: [
            gridTileFactory("Sleep Log List", AssetImage("assets/dashboard/baby-boy.png")),
            gridTileFactory("Line Chart",AssetImage("assets/dashboard/babytracker-blog-logo.png")),
            gridTileFactory("Bar Graph",AssetImage("assets/dashboard/babytracker-forum-logo.png")),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    _populateData();
  }
}
