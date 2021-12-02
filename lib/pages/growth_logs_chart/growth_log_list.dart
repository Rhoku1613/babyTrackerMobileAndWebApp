import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'growth_log_create_view.dart';

class GrowthLogsListView extends StatefulWidget {
  GrowthLogsListView({Key? key, required this.data}): super(key: key);

  final List<GrowthLogs> data;

  @override
  _GrowthLogsListView createState() => _GrowthLogsListView();
}

class _GrowthLogsListView extends State<GrowthLogsListView> {

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
          onPressed: () {
            _navigateToGrowthLogCreate();
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Growth Log List View"),
        ),
        body: ListView.builder(
          itemCount: this.widget.data.length,
          itemBuilder: _buildItemsForListView,
        ));
  }

  void _navigateToGrowthLogCreate() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const GrowthLogsCreateView()));
  }
}
