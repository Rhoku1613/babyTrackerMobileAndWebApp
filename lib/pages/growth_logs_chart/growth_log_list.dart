import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../growth_log_dashboard_view.dart';
import 'growth_log_create_view.dart';

class GrowthLogsListView extends StatefulWidget {
  GrowthLogsListView({Key? key, required this.child}): super(key: key);

  final Child child;

  @override
  _GrowthLogsListView createState() => _GrowthLogsListView();
}

class _GrowthLogsListView extends State<GrowthLogsListView> {

  List<GrowthLogs> _allGrowthLogs = [];

  @override
  void initState() {
    super.initState();
    _populateGrowthLogs();
  } // void _deleteItem(int index) async {
  //   int id = data[index].id;
  //   String response = await ChildService().delete_child_info(id);
  //   if (response == "Child info deleted successfully") {
  //     print("Operation successful");
  //   } else {
  //     print("Operation failed");
  //   }
  // }

  // Future<void> _navigateToSleepLogsCreateView() async{
  //   await Navigator.push(
  //       context, MaterialPageRoute(builder: (_) => ChildrenEnrollView()));
  // }

  void _deleteItem(int index) async {
    int id = _allGrowthLogs[index].id;
    String response = await ActivityLogService().delete_growthLog(id);
    if (response == "Growth Log Deleted Successfully") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Growth Log information deleted successfully')));
      _navigateToDashboard();
    } else {
      print("Operation failed");
    }
  }


  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
        onTap: () {},
        title: Text(this._allGrowthLogs[index].datetime),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Delete Growth Log"),
                        content: Text(
                            "Are you sure you want to delete this growth log?"),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                              onPressed: () {
                                _deleteItem(index);
                              },
                              child: Text("Delete"))
                        ],
                      ));
                },
                icon: Icon(Icons.delete)),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToGrowthLogCreate();
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Growth Log List View"),
        ),
        body: ListView.builder(
          itemCount: this._allGrowthLogs.length,
          itemBuilder: _buildItemsForListView,
        ));
  }

  void _navigateToGrowthLogCreate() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => GrowthLogsCreateView(child:this.widget.child)));
  }

  void _populateGrowthLogs(){
    ActivityLogService()
        .get_all_growth_logs(this.widget.child.id)
        .then((all_growth_logs) => {
      setState(() => {_allGrowthLogs = all_growth_logs})
    });
  }

  void _navigateToDashboard() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => GrowthLogDashboardView(child: this.widget.child)));
  }
}
