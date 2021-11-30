import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/models/forum_response.dart';
import 'package:baby_tracker/services/child_service.dart';
import 'package:baby_tracker/services/forum_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'child_detail_view.dart';
import 'children_enroll.dart';

class ChildrenListView extends StatefulWidget {
  const ChildrenListView();

  @override
  _ChildrenListView createState() => _ChildrenListView();
}

class _ChildrenListView extends State<ChildrenListView> {
  List<Child> _allChildren = <Child>[];

  @override
  void initState() {
    super.initState();
    _get_all_child();
  }

  void _get_all_child() async {
    ChildService().get_all_children().then((all_children) => {
      setState(() => { _allChildren= all_children})
    });
  }


  void _deleteItem(int index) async{
    int id=_allChildren[index].id;
    String response=await ChildService().delete_child_info(id);
    if(response=="Child info deleted successfully"){
      print("Operation successful");
    }else{
      print("Operation failed");
    }
  }

  Future<void> _navigateToChildrenCreate() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ChildrenEnrollView()));
  }

  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {},
  );


  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ChildrenDetailView(child: _allChildren[index])));
      },
      title: Text(_allChildren[index].name),
      subtitle: Text(_allChildren[index].weight.toString(), style: TextStyle(fontSize: 18)), trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () {

            }, icon: Icon(Icons.edit)),
            IconButton(onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title:Text("Log out"),
                    content:Text("Are you sure you want to delete this child information?"),
                    actions: <Widget>[
                      cancelButton,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToChildrenCreate,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("All Children"),
        ),
        body: ListView.builder(
          itemCount: _allChildren.length,
          itemBuilder: _buildItemsForListView,

        ));
  }
}