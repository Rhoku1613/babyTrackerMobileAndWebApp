import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'diaper_change_create_view.dart';

class DiaperChangeLogsListView extends StatefulWidget {
  DiaperChangeLogsListView({Key? key, required this.data}): super(key: key);

  final List<DiaperChangeLogs> data;

  @override
  _DiaperChangeLogsListView createState() => _DiaperChangeLogsListView();
}

class _DiaperChangeLogsListView extends State<DiaperChangeLogsListView> {

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

  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {},
  );

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
        onTap: () {},
        title: Text(this.widget.data[index].datetime),
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
          itemCount: this.widget.data.length,
          itemBuilder: _buildItemsForListView,
        ));
  }

  void _navigateToDiaperChangeLogCreate() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const DiaperLogCreateView()));
  }
}
