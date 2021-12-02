import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/pages/sleep_log_dashboard_view.dart';
import 'package:baby_tracker/pages/vaccination_log_dashboard_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'diaper_change_dashboard_view.dart';
import 'growth_log_dashboard_view.dart';

class ChildrenDetailView extends StatefulWidget {
  ChildrenDetailView({Key? key, required this.child}): super(key: key);

  final Child child;


  @override
  State<ChildrenDetailView> createState() => _ChildrenDetailViewState();
}

class _ChildrenDetailViewState extends State<ChildrenDetailView> {
  Future<void> _navigateToSleepLogDashboard() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => SleepLogDashboardView(child: this.widget.child,)));
  }

  Future<void> _navigateToGrowthLogDashboard() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => GrowthLogDashboardView(child: this.widget.child,)));
  }

  Future<void> _navigateToDiaperChangeLog() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => DiaperChangeLogDashboardView(child: this.widget.child,)));
  }

  Future<void> _navigateToVaccinationLogs() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => VaccinationLogDashboardView(child: this.widget.child,)));
  }




  GridTile gridTileFactory(String title, AssetImage assetImage) {
    return GridTile(
      footer: Text(title),
      child: GestureDetector(
        onTap: () {
          if(title=="Sleep Log"){
            _navigateToSleepLogDashboard();
          }else if(title=="Vaccination Log"){
            _navigateToVaccinationLogs();
          }else if(title=="Growth Log"){
            _navigateToGrowthLogDashboard();
          }else if(title=="Diaper Change Log"){
            _navigateToDiaperChangeLog();
          }

        },
        child: Image(
          image: assetImage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.widget.child.name),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: [
            gridTileFactory("Sleep Log", AssetImage("assets/dashboard/baby-boy.png")),
            gridTileFactory("Vaccination Log",AssetImage("assets/dashboard/babytracker-blog-logo.png")),
            gridTileFactory("Growth Log",AssetImage("assets/dashboard/babytracker-forum-logo.png")),
            gridTileFactory("Diaper Change Log",AssetImage("assets/dashboard/babytracker-syringe.png")),
          ],
        ));
  }
}
