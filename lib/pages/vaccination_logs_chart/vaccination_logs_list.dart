import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/pages/vaccination_log_dashboard_view.dart';
import 'package:baby_tracker/pages/vaccination_logs_chart/vaccination_create_view.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VaccinationLogsListView extends StatefulWidget {
  VaccinationLogsListView({Key? key, required this.child}): super(key: key);

  final Child child;

  @override
  _VaccinationLogsListView createState() => _VaccinationLogsListView();
}

class _VaccinationLogsListView extends State<VaccinationLogsListView> {

  List<Vaccine> _allVaccineLogs=[];

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

  void _deleteItem(int index) async{
    int id=this._allVaccineLogs[index].id;
    String response=await ActivityLogService().delete_vaccinationLog(id);
    if(response=="Vaccine Log Deleted Successfully"){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Vaccine Log information deleted successfully')));
      _navigateToDashboard();
    }else{
      print("Operation failed");
    }
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
        onTap: () {},
        title: Text(this._allVaccineLogs[index].name),
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
                              onPressed: () {
                                //delete item first
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
            _navigateToVaccinationLogCreateView();

          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Vaccination Log List View"),
        ),
        body: ListView.builder(
          itemCount: this._allVaccineLogs.length,
          itemBuilder: _buildItemsForListView,
        ));
  }

  void _navigateToVaccinationLogCreateView() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => VaccinationLogsCreateView(child: this.widget.child,)));
  }

  @override
  void initState() {
    super.initState();
    _populateList();

  }

  void _populateList() {
    ActivityLogService()
        .get_all_vaccine_logs(this.widget.child.id)
        .then((allVaccineLogs) => {
      setState(() => {this._allVaccineLogs = allVaccineLogs})
    });
  }

  void _navigateToDashboard() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => VaccinationLogDashboardView(child: this.widget.child)));
  }
}
