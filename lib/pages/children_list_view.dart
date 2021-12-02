import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/pages/dashboard_view.dart';
import 'package:baby_tracker/services/child_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'child_detail_view.dart';
import 'children_enroll.dart';

class ChildrenListView extends StatefulWidget {
  @override
  _ChildrenListView createState() => _ChildrenListView();
}

class _ChildrenListView extends State<ChildrenListView> {
  List<Child> data=[];


  Future<void> _navigateToChildrenCreate() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ChildrenEnrollView()));
  }

  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {},
  );




  @override
  Widget build(BuildContext context) {

    void _deleteItem(int index) async{
      int id=this.data[index].id;
      String response=await ChildService().delete_child_info(id);
      if(response=="Child info deleted successfully"){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Child information deleted successfully')));
        _navigateToDashboard();
      }else{
        print("Operation failed");
      }
    }

    ListTile _buildItemsForListView(BuildContext context, int index) {
      return ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ChildrenDetailView(child: this.data[index])));
          },
          title: Text(this.data[index].name),
          subtitle: Text(this.data[index].weight.toString()+" lbs", style: TextStyle(fontSize: 18)), trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title:Text("Log out"),
                  content:Text("Are you sure you want to delete this child information.All related information about this child will be removed?"),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(onPressed: (){
                      //delete item first
                      _deleteItem(index);
                      setState(() {});
                    }, child: Text("Delete"))
                  ],
                )
            );
          }, icon: Icon(Icons.delete)),
        ],
      )
      );
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToChildrenCreate,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("All Children"),
        ),
        body: ListView.builder(
          itemCount: this.data.length,
          itemBuilder: _buildItemsForListView,

        ));
  }

  void _navigateToDashboard() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const DashboardView()));
  }

  @override
  void initState() {
    super.initState();
    _populateChildren();
  }

  void _populateChildren() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token=prefs.getString("access_token");
    List<Child> children=await ChildService().get_children_by_access_token(access_token!);
    setState(() {
      this.data=children;
    });

  }
}
