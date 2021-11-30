import 'package:baby_tracker/models/forum_response.dart';
import 'package:baby_tracker/pages/forum_post_create.dart';
import 'package:baby_tracker/services/forum_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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


  Future<void> _navigateToForumCreate() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ForumCreateView()));
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: Text(_allForumPost[index].title),
      subtitle: Text(_allForumPost[index].body, style: TextStyle(fontSize: 18)),
    );
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
