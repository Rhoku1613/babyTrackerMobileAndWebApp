import 'dart:convert';

import 'package:baby_tracker/models/blog_response.dart';
import 'package:http/http.dart' as http;
import '../secrets.dart';

class BlogService {
  final base_url = baseUrl;

  Future<List<Blog>> get_all_blogs() async {
    final url = this.base_url + "blogs/";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<Blog> allBlogs = List<Blog>.from(
          json.decode(response.body).map((x) => Blog.fromJson(x)));
      return allBlogs;
    } else {
      throw Exception("Cannot get blogs");
    }
  }

  Future<Blog> get_blog(int id) async {
    final url = this.base_url + "/blogs/$id";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Blog blog = Blog.fromJson(jsonDecode(response.body));
      return blog;
    } else {
      throw Exception("Cannot get blogs");
    }
  }

  Future<String> create_blog(Blog blog) async {
    final url = this.base_url + "/blogs/";
    final response =
        http.post(Uri.parse(url), headers: {}, body: jsonEncode(blog));
    if (response == 201) {
      return "Resource created successfully";
    } else {
      throw Exception("Cannot create blogs");
    }
  }

  Future<String> delete_blog(int id) async{
    final url = this.base_url + "/blogs/$id";
    final response =http.delete(Uri.parse(url));
    if (response == 200) {
      return "Resource deleted successfully";
    } else {
      throw Exception("Cannot create blogs");
    }
  }


  Future<String> edit_blog(int id,Blog blog) async{
    final url = this.base_url + "/blogs/$id";
    final response =http.put(Uri.parse(url),headers: {},body: jsonEncode(blog));
    if (response == 200) {
      return "Resource edited successfully";
    } else {
      throw Exception("Cannot edit blogs");
    }
  }
}
