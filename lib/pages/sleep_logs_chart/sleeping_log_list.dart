import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/pages/sleep_logs_chart/sleep_logs_create.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:baby_tracker/services/child_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SleepLogsListView extends StatefulWidget {
  const SleepLogsListView();

  @override
  _SleepLogsListView createState() => _SleepLogsListView();
}

class _SleepLogsListView extends State<SleepLogsListView> {
  List<SleepLogs> _allSleepLogs = <SleepLogs>[];
  int child_id = 3;
  @override
  void initState() {
    super.initState();
    _get_all_sleep_logs();
  }

  void _get_all_sleep_logs() async {
    ActivityLogService()
        .get_all_sleep_logs(this.child_id)
        .then((all_sleepLogs) => {
              setState(() => {_allSleepLogs = all_sleepLogs})
            });
  }

  void _deleteItem(int index) async {
    int id = _allSleepLogs[index].id;
    String response = await ChildService().delete_child_info(id);
    if (response == "Child info deleted successfully") {
      print("Operation successful");
    } else {
      print("Operation failed");
    }
  }

  // Future<void> _navigateToSleepLogsCreateView() async{
  //   await Navigator.push(
  //       context, MaterialPageRoute(builder: (_) => ChildrenEnrollView()));
  // }

  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {},
  );

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
        onTap: () {},
        title: Text(_allSleepLogs[index].date),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Delete Sleep Log"),
                            content: Text(
                                "Are you sure you want to delete this sleep log?"),
                            actions: <Widget>[
                              cancelButton,
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
        context, MaterialPageRoute(builder: (_) => const SleepLogsCreateView()));
  }
}
