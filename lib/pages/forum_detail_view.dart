import 'package:baby_tracker/models/forum_response.dart';
import 'package:baby_tracker/services/forum_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ForumDetailView extends StatefulWidget {
  ForumDetailView({Key? key, required this.forum}) : super(key: key);

  final Forum forum;

  @override
  State<ForumDetailView> createState() => _ForumDetailViewState();
}

class _ForumDetailViewState extends State<ForumDetailView> {
  List<Comments> _allComments = [];

  GridTile gridTileFactory(String title, AssetImage assetImage) {
    return GridTile(
      footer: Text(title),
      child: GestureDetector(
        onTap: () {},
        child: Image(
          image: assetImage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.widget.forum.title),
        ),
        body: Column(
          children: [
            Text(this.widget.forum.title),
            Text(this.widget.forum.body),
            Divider(
              height: 10,
            ),
            Text("Comments"),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _allComments.length,
              itemBuilder: (context, index){
                return Text(_allComments[index].comment);
              },
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    _getForumPostComments();
  }

  void _getForumPostComments() async {
    List<Comments> comments =
        await ForumService().get_all_forum_post_comment(this.widget.forum.id);
    setState(() {
      _allComments = comments;
    });
  }
}
