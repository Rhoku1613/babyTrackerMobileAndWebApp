import 'package:baby_tracker/models/blog_response.dart';
import 'package:baby_tracker/services/blog_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'blog_detail_view.dart';

class BlogListView extends StatefulWidget {
  const BlogListView();

  @override
  _BlogListViewState createState() => _BlogListViewState();
}

class _BlogListViewState extends State<BlogListView> {

  List<Blog> _allBlogs = <Blog>[];

  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {},
  );



  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>BlogDetailView(blog: _allBlogs[index],)));
        },
        title: Text(_allBlogs[index].title),
        subtitle: Text(_allBlogs[index].body, style: TextStyle(fontSize: 18)),
    );
  }

  @override
  void initState() {
    super.initState();
    _get_all_blogs();
  }

  void _get_all_blogs() async {
    BlogService().get_all_blogs().then((all_blogs) => {
          setState(() => {_allBlogs = all_blogs})
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("All Blogs"),
       ),
        body: ListView.builder(
      itemCount: _allBlogs.length,
      itemBuilder: _buildItemsForListView,
    ));
  }
}
