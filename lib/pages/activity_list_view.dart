import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/services/activity_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityListView extends StatefulWidget {
  const ActivityListView();

  @override
  _ActivityListViewState createState() => _ActivityListViewState();
}

class _ActivityListViewState extends State<ActivityListView> {
  List<Activity> _allActivities = <Activity>[];

  @override
  void initState() {
    super.initState();
    _get_all_activities();
  }

  void _get_all_activities() async {
    ActivityService().get_all_activities().then((all_blogs) => {
          setState(() => {_allActivities = all_blogs})
        });
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: Text(_allActivities[index].type),
      subtitle: Text(_allActivities[index].id.toString(),
          style: TextStyle(fontSize: 18)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: new IconTheme(
              data: new IconThemeData(color: Colors.yellow),
              child: new Icon(Icons.add),
            )),
        appBar: AppBar(
          title: Text("All Activities"),
        ),
        body: ListView.builder(
          itemCount: _allActivities.length,
          itemBuilder: _buildItemsForListView,
        ));
  }
}
