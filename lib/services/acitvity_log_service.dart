import 'dart:convert';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:http/http.dart' as http;
import '../secrets.dart';

class ActivityLogService{
  final base_url=baseUrl;


  Future<List<Vaccine>> get_all_vaccination() async{
    final url=this.base_url+"vaccine/";
    final response=await http.get(Uri.parse(url));
    if (response.statusCode==200){
      print("printing response");
      List<Vaccine> all_vaccine_logs=List<Vaccine>.from(
          json.decode(response.body).map((x) => Vaccine.fromJson(x)));
      return all_vaccine_logs;
    }else{
      throw Exception("Cannot get vaccination logs");
    }
  }


  Future<List<SleepLogs>> get_all_sleep_logs(int id) async{
    final url=this.base_url+"sleep/";
    final response=await http.get(Uri.parse(url));
    if (response.statusCode==200){
      print("printing response");
      List<SleepLogs> all_sleep_logs=List<SleepLogs>.from(
          json.decode(response.body).map((x) => SleepLogs.fromJson(x)));
      return all_sleep_logs;
    }else{
      throw Exception("Cannot get sleep logs");
    }
  }

  Future<List<GrowthLogs>> get_all_growth_logs(int id) async{
    final url=this.base_url+"growth/";
    final response=await http.get(Uri.parse(url));
    if (response.statusCode==200){
      print("printing response");
      List<GrowthLogs> all_growth_logs=List<GrowthLogs>.from(
          json.decode(response.body).map((x) => GrowthLogs.fromJson(x)));
      return all_growth_logs;
    }else{
      throw Exception("Cannot get growth logs");
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