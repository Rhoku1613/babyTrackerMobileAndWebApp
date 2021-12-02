import 'package:baby_tracker/models/forum_response.dart';
import 'package:baby_tracker/pages/forum_post_create.dart';
import 'package:baby_tracker/services/forum_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'forum_detail_view.dart';

class ForumListView extends StatefulWidget {
  const ForumListView();

  @override
  _ForumListViewState createState() => _ForumListViewState();
}

class _ForumListViewState extends State<ForumListView> {
  List<Forum> _allForumPost = <Forum>[];

  @override
  void initState() {
    super.initState();
    _get_all_forum_posts();
  }

  void _get_all_forum_posts() async {
    ForumService().get_all_forum_posts().then((all_posts) => {
      setState(() => {_allForumPost = all_posts})
    });
  }

  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {},
  );

  void _deleteItem(int index) async{
    int id=_allForumPost[index].id;
    String response=await ForumService().delete_forum_post(id);
    if(response=="Forum info deleted successfully"){
      print("Operation successful");
    }else{
      print("Operation failed");
    }
  }


  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ForumDetailView(forum: _allForumPost[index],)));
        },
        title: Text(_allForumPost[index].title),
        subtitle: Text(_allForumPost[index].body, style: TextStyle(fontSize: 18)), trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        IconButton(onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title:Text("Log out"),
                content:Text("Are you sure you want to delete this child information?"),
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


  Future<void> _navigateToForumCreate() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ForumCreateView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(
         onPressed: _navigateToForumCreate,
         child: Icon(Icons.add),
       ),
        appBar: AppBar(
          title: Text("All Forum Posts"),
        ),
        body: ListView.builder(
          itemCount: _allForumPost.length,
          itemBuilder: _buildItemsForListView,
        ));
  }
}
