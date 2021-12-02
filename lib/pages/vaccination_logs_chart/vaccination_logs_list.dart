import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/pages/vaccination_logs_chart/vaccination_create_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VaccinationLogsListView extends StatefulWidget {
  VaccinationLogsListView({Key? key, required this.data}): super(key: key);

  final List<Vaccine> data;

  @override
  _VaccinationLogsListView createState() => _VaccinationLogsListView();
}

class _VaccinationLogsListView extends State<VaccinationLogsListView> {

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
        title: Text(this.widget.data[index].name),
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
            _navigateToVaccinationLogCreateView();

          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Vaccination Log List View"),
        ),
        body: ListView.builder(
          itemCount: this.widget.data.length,
          itemBuilder: _buildItemsForListView,
        ));
  }

  void _navigateToVaccinationLogCreateView() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const VaccinationLogsCreateView()));
  }
}
