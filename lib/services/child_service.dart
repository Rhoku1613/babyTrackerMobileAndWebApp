import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/models/forum_response.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../secrets.dart';
import 'dart:convert';

class ChildService {
  final base_url = baseUrl;

  Future<List<Child>> get_all_children() async {
    final url = this.base_url + "children/";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      List<Child> all_children = List<Child>.from(
          json.decode(response.body).map((x) => Child.fromJson(x)));
      return all_children;
    } else {
      throw Exception("Cannot get children");
    }
  }


  Future<String> enroll_a_child(Child child) async{
    final url = this.base_url + "children/";
    try {
      final response = await Dio().post(url,
          data: {
            'name': child.name,
            'dob': child.dob,
            'weight': child.weight,
            'height':child.height,
            'parent':child.parent,
            'gender':child.gender
          },
          options: Options(contentType: "application/json"));

      if (response.statusCode == 201) {
        return "Child enrolled successfully";
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

  Future<List<Child>> get_all_children_of_a_user(User user) async {
    final url = this.base_url + "/user/child/";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<Child> all_children = List<Child>.from(
          json.decode(response.body).map((x) => Child.fromJson(x)));
      return all_children;
    }else{
      throw Exception("Cannot get children");
    }
  }


  Future<Child> get_child_info(int id) async{
    final url=this.base_url+"/child/$id";
    final response=await http.get(Uri.parse(url));
    if(response.statusCode==200){
      return Child.fromJson(json.decode(response.body));
    }else{
      throw Exception("Cannot get child info");
    }
  }

  Future<String> delete_child_info(int id) async{
    final url=this.base_url+"children/$id";
    final response=await http.delete(Uri.parse(url));
    if(response.statusCode==200){
      return "Child info deleted successfully";
    }else{
      throw Exception("Cannot get child info");
    }
  }


}
