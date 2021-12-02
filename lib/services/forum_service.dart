import 'dart:convert';

import 'package:baby_tracker/models/forum_response.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../secrets.dart';

class ForumService {
  final base_url = baseUrl;

  Future<List<Forum>> get_all_forum_posts() async {
    final url = this.base_url + "forum/";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("printing response");
      print(json.decode(response.body));
      List<Forum> allForum = List<Forum>.from(
          json.decode(response.body).map((x) => Forum.fromJson(x)));
      return allForum;
    } else {
      throw Exception("Cannot get blogs");
    }
  }

  Future<List<Comments>> get_all_forum_post_comment(int post_id) async {
    final url = this.base_url + "forum/comments?post_id=$post_id";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<Comments> allComments = List<Comments>.from(
          json.decode(response.body).map((x) => Comments.fromJson(x)));
      return allComments;
    } else {
      throw Exception("Cannot get blogs");
    }
  }



  Future<String> create_forum_post(Forum forum) async {
    final url = this.base_url + "forum/";
    try {
      final response = await Dio().post(url,
          data: {
            'post_title': forum.title,
            'post_body': forum.body,
            'post_author': forum.author
          },
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200) {
        return "Forum post created successfully";
      } else {
        throw Exception("Failed to sign in");
        return "Cannot create a post";
      }
    } catch (e) {
      if (e is DioError) {
        return "An error occurred";
      }
    }
    return "Error";
  }

  Future<Forum> get_forum_post(int id) async {
    final url = this.base_url + "forum/$id";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Forum.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Cannot get the forum post");
    }
  }

  Future<String> edit_forum_post(int id, Forum forum) async {
    final url = this.base_url + "/forum/$id";
    final response =
        await http.put(Uri.parse(url), headers: {}, body: jsonEncode(forum));
    if (response.statusCode == 200) {
      return "Post edited successfully";
    } else {
      throw Exception("Cannot edit post");
    }
  }

  Future<String> delete_forum_post(int id) async {
    final url = this.base_url + "/forum/$id";
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      return "Post deleted successfully";
    } else {
      throw Exception("Forum post deleted successfully");
    }
  }
}
