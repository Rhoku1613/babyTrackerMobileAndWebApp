import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/models/forum_response.dart';
import 'package:baby_tracker/pages/sleep_log_dashboard_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'growth_log_dashboard_view.dart';

class ForumDetailView extends StatefulWidget {
  ForumDetailView({Key? key, required this.forum}): super(key: key);

  final Forum forum;


  @override
  State<ForumDetailView> createState() => _ForumDetailViewState();
}

class _ForumDetailViewState extends State<ForumDetailView> {

  GridTile gridTileFactory(String title, AssetImage assetImage) {
    return GridTile(
      footer: Text(title),
      child: GestureDetector(
        onTap: () {
        },
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
        body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: [
            gridTileFactory("Sleep Log", AssetImage("assets/dashboard/baby-boy.png")),
            gridTileFactory("Vaccination Log",AssetImage("assets/dashboard/babytracker-blog-logo.png")),
            gridTileFactory("Growth Log",AssetImage("assets/dashboard/babytracker-forum-logo.png")),
            gridTileFactory("Diaper Change Log",AssetImage("assets/dashboard/babytracker-syringe.png")),
          ],
        ));
  }
}
