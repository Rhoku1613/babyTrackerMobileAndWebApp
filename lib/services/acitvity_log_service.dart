import 'dart:convert';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:dio/dio.dart';
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
    final url=this.base_url+"child/sleep-records?child_id=$id";
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

  Future<List<Vaccine>> get_all_vaccine_logs(int id) async{
    final url=this.base_url+"child/vaccine-records?child_id=$id";
    final response=await http.get(Uri.parse(url));
    if (response.statusCode==200){
      print("printing response");
      List<Vaccine> all_vaccine_logs=List<Vaccine>.from(
          json.decode(response.body).map((x) => Vaccine.fromJson(x)));
      return all_vaccine_logs;
    }else{
      throw Exception("Cannot get sleep logs");
    }
  }


  Future<List<GrowthLogs>> get_all_growth_logs(int id) async{
    final url=this.base_url+"child/growth-records?child_id=$id";
    final response=await http.get(Uri.parse(url));
    if (response.statusCode==200){
      print("printing response");
      print(json.decode(response.body));
      List<GrowthLogs> all_growth_logs = List<GrowthLogs>.from(
          json.decode(response.body).map((x) => GrowthLogs.fromJson(x)));
      return all_growth_logs;
    }else{
      throw Exception("Cannot get growth logs");
    }
  }

  Future<List<DiaperChangeLogs>> get_all_diaper_change_logs(int id) async{
    final url=this.base_url+"child/diaper-records?child_id=$id";
    final response=await http.get(Uri.parse(url));
    if (response.statusCode==200){
      print("printing response");
      print(json.decode(response.body));
      List<DiaperChangeLogs> all_diaper_logs = List<DiaperChangeLogs>.from(
          json.decode(response.body).map((x) => DiaperChangeLogs.fromJson(x)));
      return all_diaper_logs;
    }else{
      throw Exception("Cannot get diaper logs");
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


  Future<String> add_diaper_change_log(DiaperChangeLogs diaperChangeLogs) async{
    final url = this.base_url + "diaper/";
    try {
      final response = await Dio().post(url,
          data: {
            'datetime': diaperChangeLogs.datetime,
            'description': diaperChangeLogs.description,
            'child': diaperChangeLogs.child,
          },
          options: Options(contentType: "application/json"));

      if (response.statusCode == 201) {
        return "Diaper change log added successfully";
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


  Future<String> add_growth_log(GrowthLogs growthLogs) async{
    final url = this.base_url + "growth/";
    try {
      final response = await Dio().post(url,
          data: {
            'datetime': growthLogs.datetime,
            'height': growthLogs.height,
            'child': growthLogs.child,
          },
          options: Options(contentType: "application/json"));

      if (response.statusCode == 201) {
        return "Growth log added successfully";
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

  Future<String> add_sleep_log(SleepLogs sleepLogs) async{
    final url = this.base_url + "sleep/";
    try {
      final response = await Dio().post(url,
          data: {
            'date': sleepLogs.date,
            'start':sleepLogs.start,
            'end': sleepLogs.end,
            'child': sleepLogs.child,
          },
          options: Options(contentType: "application/json"));

      if (response.statusCode == 201) {
        return "Sleep log added successfully";
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

  Future<String> add_vaccine_log(Vaccine vaccineLogs) async{
    final url = this.base_url + "vaccine/";
    try {
      final response = await Dio().post(url,
          data: {
            'date': vaccineLogs.date,
            'name':vaccineLogs.name,
            'number_of_doses': vaccineLogs.numberOfDoses,
            'number_of_doses_taken':vaccineLogs.numberOfDosesTaken,
            'child': vaccineLogs.child,
          },
          options: Options(contentType: "application/json"));

      if (response.statusCode == 201) {
        return "Vaccine log added successfully";
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



}