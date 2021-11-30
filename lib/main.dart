import 'package:baby_tracker/pages/home_page.dart';
import 'package:baby_tracker/pages/dashboard_page.dart';
import 'package:baby_tracker/services/base_service.dart';
import 'package:baby_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




void main() {
  runApp(BabyTrackerApp());
}

class BabyTrackerApp extends StatelessWidget {
  static const supabaseGreen = Color.fromRGBO(101, 217, 165, 1.0);

  const BabyTrackerApp();

  @override
  Widget build(BuildContext context) {
    return Services(
      child: MaterialApp(
        title: 'BabyTracker',
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          fontFamily: 'Georgia',
        ),
        home: Builder(
          builder: (context) {
            return FutureBuilder<bool>(
              future: Services.of(context).authService.recoverSession(),
              builder: (context, snapshot) {
                final sessionRecovered = snapshot.data ?? false;
                return sessionRecovered ? DashboardPage() : HomePage();
              },
            );
          },
        ),
      ),
    );
  }
}