import 'package:baby_tracker/pages/children_list_view.dart';
import 'package:baby_tracker/pages/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'blog_list_view.dart';
import 'forum_list_view.dart';
import 'home_page.dart';

class DashboardView extends StatefulWidget {
  const DashboardView();

  @override
  _DashboardView createState() => _DashboardView();
}

class _DashboardView extends State<DashboardView> {
  Future<void> _navigateToSettings() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => SettingsView()));
  }

  Future<void> _navigateToBlogs() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => BlogListView()));
  }

  Future<void> _navigateToForum() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => ForumListView()));
  }

  Future<void> _navigateToChildrenList() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => ChildrenListView()));
  }


  GridTile gridTileFactory(String title, AssetImage assetImage) {
    return GridTile(
      footer: Text(title),
      child: GestureDetector(
        onTap: () {
          if (title == "Blogs") {
            _navigateToBlogs();
          } else if (title == "Forum") {
            _navigateToForum();
          }else if(title=="Children"){
            _navigateToChildrenList();
          }
        },
        child: Image(
          image: assetImage,
        ),
      ),
    );
  }

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {},
  );


  Future<void> _signOut(BuildContext context) async {
     //logic to sign out

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Dashboard"), actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: PopupMenuButton<int>(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: TextButton(
                            child: Text('Settings'),
                            onPressed: _navigateToSettings,
                          ),
                        ),
                        PopupMenuItem(
                            child: TextButton(
                          child: Text('Logout'),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:Text("Log out"),
                              content:Text("Are you sure you want to log out?"),
                              actions: <Widget>[
                                cancelButton,
                                TextButton(onPressed: (){
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (_) => HomePage()));
                                }, child: Text("Logout"))
                              ],
                            )
                          ),
                        )),
                      ])),
        ]),
        body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: [
            gridTileFactory("Children", AssetImage("assets/dashboard/baby-boy.png")),
            gridTileFactory("Blogs",AssetImage("assets/dashboard/babytracker-blog-logo.png")),
            gridTileFactory("Forum",AssetImage("assets/dashboard/babytracker-forum-logo.png")),
            gridTileFactory("Vaccination Logs",AssetImage("assets/dashboard/babytracker-syringe.png")),
            gridTileFactory("Sleep Logs",AssetImage("assets/dashboard/babyTracker-sleep.png")),
            gridTileFactory("Growth Logs",AssetImage("assets/dashboard/babyTracker-growth-logs.png"))
          ],
        ));
  }
}
