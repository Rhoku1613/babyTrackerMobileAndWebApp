import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';
import '../secrets.dart';
import 'package:dio/dio.dart';

class AuthService {
  static const supabaseSessionKey = 'supabase_session';
  final base_url = baseUrl;
  final GoTrueClient _client;

  AuthService(this._client) {
    _client.refreshSession();
  }

  Future<bool> signUp(String email, String password) async {
    final response = await _client.signUp(email, password);
    if (response.error == null) {
      print(response.user);
      //log('Sign up was successful for user ID: ${response.user!.id}');
      //_persistSession(response.data!);
      return true;
    }
    log('Sign up error: ${response.error!.message}');
    return false;
  }

  Future<bool> signIn(String username, String password) async {

    final url = this.base_url + "api/v1/token/";
    try{
    final response=await Dio().post(url, data: {'username': username, 'password': password},options: Options(contentType: "application/json"));

      if (response.statusCode == 200) {
        print("got response");
        print("Access token:$response.data['access']");
        print("Refresh token:$response.data['refresh']");
        return true;
      }else {
        throw Exception("Failed to sign in");
        return false;
      }}catch(e){
      if(e is DioError){
        return false;
      }
    }

    return false;


    // final url=baseUrl+"/token/";
    // final response=await http.post(Uri.parse(url));
    // print(response.body);
    // return false;
    // final response = await _client.signIn(email: email, password: password);
    // if (response.error == null) {
    //   log('Sign in was successful for user ID: ${response.user!.id}');
    //   _persistSession(response.data!);
    //   return true;
    // }
    // log('Sign in error: ${response.error!.message}');
    // return false;
  }

  Future<void> _persistSession(Session session) async {
    final prefs = await SharedPreferences.getInstance();
    log('Persisting session string');
    await prefs.setString(supabaseSessionKey, session.persistSessionString);
  }

  Future<bool> signOut() async {
    final response = await _client.signOut();
    if (response.error == null) {
      log('Successfully logged out; clearing session string');
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(supabaseSessionKey);
      return true;
    }
    log('Log out error: ${response.error!.message}');
    return false;
  }

  Future<bool> recoverSession() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(supabaseSessionKey)) {
      log('Found persisted session string, attempting to recover session');
      final jsonStr = prefs.getString(supabaseSessionKey)!;
      final response = await _client.recoverSession(jsonStr);
      if (response.error == null) {
        log('Session successfully recovered for user ID: ${response.user!.id}');
        _persistSession(response.data!);
        return true;
      }
    }
    return false;
  }
}
