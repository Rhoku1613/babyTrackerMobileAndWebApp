import 'package:baby_tracker/services/BaseService.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage();

  Future<void> _signOut(BuildContext context) async {
    final success = await Services.of(context).authService.signOut();
    if (success) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('There was an issue logging out.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Your Awesome Dashboard'),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await _signOut(context);
              },
              icon: Icon(Icons.login),
              label: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}