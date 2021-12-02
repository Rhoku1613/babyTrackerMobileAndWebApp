import 'package:baby_tracker/models/forum_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../secrets.dart';

class AccountService{
  final base_url=baseUrl;



  Future<User?> get_logged_in_user(String access_token) async{
    final url=this.base_url+"api/v1/user/current";
    try {
      var response = await Dio().get(url,options: Options(
        headers: {
          "Authorization":"Bearer $access_token"
        }
      ));
      return User.fromJson(response.data);
    } catch (e) {
      print(e);
    }

    return null;
  }



}