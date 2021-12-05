import 'package:baby_tracker/pages/forum_list_view.dart';
import 'package:baby_tracker/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'activity_list_view.dart';
import 'blog_list_view.dart';
import 'children_list_view.dart';
import 'dashboard_page.dart';
import 'dashboard_view.dart';
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
          context, MaterialPageRoute(builder: (_) => const DashboardPage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something went wrong.')));
    }
  }

  Future<void> _navigateToLogin() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  Future<void> _navigateToSignUp() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SignUpPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: ElevatedButton.icon(
                onPressed: _navigateToLogin,
                icon: const Icon(Icons.login),
                label: const Text('Sign in'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: _navigateToSignUp,
                icon: const Icon(Icons.app_registration),
                label: const Text('Sign up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
