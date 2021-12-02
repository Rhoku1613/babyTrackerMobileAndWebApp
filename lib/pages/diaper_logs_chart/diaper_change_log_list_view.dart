import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'diaper_change_create_view.dart';

class DiaperChangeLogsListView extends StatefulWidget {
  DiaperChangeLogsListView({Key? key, required this.child}): super(key: key);

  final Child child;

  @override
  _DiaperChangeLogsListView createState() => _DiaperChangeLogsListView();
}

class _DiaperChangeLogsListView extends State<DiaperChangeLogsListView> {

  List<DiaperChangeLogs> _allDiaperChangeLogs=[];

  // void _deleteItem(int index) async {
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



  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
        onTap: () {},
        title: Text(this._allDiaperChangeLogs[index].description),
        subtitle: Text(this._allDiaperChangeLogs[index].datetime),
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
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                              onPressed: () async{
                                //delete item first
                                String response=await ActivityLogService().delete_diaperChangeLog(this._allDiaperChangeLogs[index].id);
                                if(response=="Diaper Change Log Deleted Successfully"){
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text('Diaper Change Log Deleted Successfully')));
                                }else{
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text('Diaper Change Log Delete Failed.Please try Again Later')));
                                }
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
          onPressed: _navigateToDiaperChangeLogCreate,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Diaper Change Log List View"),
        ),
        body: ListView.builder(
          itemCount: this._allDiaperChangeLogs.length,
          itemBuilder: _buildItemsForListView,
        ));
  }

  void _navigateToDiaperChangeLogCreate() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => DiaperLogCreateView(child: this.widget.child,)));
  }

  @override
  void initState() {
    super.initState();
    _populateDiaperChangeList();
  }

  void _populateDiaperChangeList() {
    ActivityLogService()
        .get_all_diaper_change_logs(this.widget.child.id)
        .then((all_diaper_change_logs) => {
      setState(() => {_allDiaperChangeLogs = all_diaper_change_logs})
    });
  }
}

