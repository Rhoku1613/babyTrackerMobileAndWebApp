import 'dart:convert';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:http/http.dart' as http;
import '../secrets.dart';

class ActivityService{
  final base_url=baseUrl;


  Future<List<Activity>> get_all_activities() async{
    final url=this.base_url+"activity/";
    final response=await http.get(Uri.parse(url));
    if (response.statusCode==200){
      print("printing response");
      List<Activity> all_blogs=List<Activity>.from(
          json.decode(response.body).map((x) => Activity.fromJson(x)));
      return all_blogs;
    }else{
      throw Exception("Cannot get blogs");
    }
  }


  Future<Activity> get_activity(int id) async{
    final url=this.base_url+"/activity/$id";
    final response=await http.get(Uri.parse(url));
    if (response.statusCode==200){
      print("Printing response");
      Activity activity=Activity.fromJson(jsonDecode(response.body));
      return activity;
    }else{
      throw Exception("Cannot get activity");
    }
  }


  Future<String> edit_activity(int id,Activity activity) async{
    final url=this.base_url+"/activity/$id";
    final response=await http.put(Uri.parse(url),headers:{},body: json.encode(activity));
    if(response.statusCode==200){
      return "Activity edited successfully";
    }else{
      throw Exception("Cannot edit activity");
    }
  }

  Future<String> delete_activity(int id) async{
    final url=this.base_url+"/activity/$id";
    final response=await http.put(Uri.parse(url),headers:{});
    if(response.statusCode==200){
      return "Activity Deleted Successfully";
    }else{
      throw Exception("Activity could not be delete");
    }
  }


}