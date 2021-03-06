import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/pages/sleep_logs_chart/sleep_logs_create.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sleep_log_dashboard_view.dart';

class SleepLogsListView extends StatefulWidget {

  SleepLogsListView({Key? key, required this.child}): super(key: key);

  final Child child;

  @override
  _SleepLogsListView createState() => _SleepLogsListView();
}

class _SleepLogsListView extends State<SleepLogsListView> {
  List<SleepLogs> _allSleepLogs = <SleepLogs>[];
  @override
  void initState() {
    super.initState();
    _get_all_sleep_logs();
  }

  void _get_all_sleep_logs() async {
    ActivityLogService()
        .get_all_sleep_logs(this.widget.child.id)
        .then((all_sleepLogs) => {
              setState(() => {_allSleepLogs = all_sleepLogs})
            });
  }

  void _deleteItem(int index) async {
    int id = _allSleepLogs[index].id;
    String response = await ActivityLogService().delete_sleepLog(id);
    if (response == "Sleep Log Deleted Successfully") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sleep Log information deleted successfully')));
      _navigateToDashboard();
    } else {
      print("Operation failed");
    }
  }


  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {},
  );

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
        onTap: () {},
        title: Text("Record of sleep log of "+_allSleepLogs[index].date),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Delete Sleep Log"),
                            content: Text(
                                "Are you sure you want to delete this sleep log?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                  onPressed: () {
                                    //delete item first
                                    _deleteItem(index);
                                    setState(() {});
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
            _navigateToSleepLogAdd();
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Sleep Log List View"),
        ),
        body: ListView.builder(
          itemCount: _allSleepLogs.length,
          itemBuilder: _buildItemsForListView,
        ));
  }

  void _navigateToSleepLogAdd() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => SleepLogsCreateView(child: this.widget.child,)));
  }

  void _navigateToDashboard() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => SleepLogDashboardView(child: this.widget.child)));
  }
}
