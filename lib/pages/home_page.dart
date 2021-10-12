import 'package:baby_tracker/pages/signup_page.dart';
import 'package:baby_tracker/services/BaseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dashboard_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  Future<void> _handleResponse(bool success) async {
    if (success) {
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => DashboardPage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something went wrong.')));
    }
  }

  Future<void> _navigateToLogin() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  Future<void> _navigateToSignUp() async{
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => SignUpPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: _navigateToLogin,
              icon: Icon(Icons.login),
              label: Text('Sign in'),
            ),
            ElevatedButton.icon(
              onPressed: _navigateToSignUp,
              icon: Icon(Icons.app_registration),
              label: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}