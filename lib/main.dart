import 'package:baby_tracker/pages/home_page.dart';
import 'package:baby_tracker/pages/dashboard_page.dart';
import 'package:baby_tracker/services/base_service.dart';
import 'package:baby_tracker/theme/theme.dart';
import 'package:baby_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';




void main() {
  runApp(BabyTrackerApp());
}

class BabyTrackerApp extends StatelessWidget {
  static const supabaseGreen = Color.fromRGBO(101, 217, 165, 1.0);

  const BabyTrackerApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_)=>ThemeChanger(ThemeData.light()),
      child: MaterialAppWithTheme(),

    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme=Provider.of<ThemeChanger>(context);
    return Services(
      child: MaterialApp(
        title: 'BabyTracker',
        theme: theme.getTheme(),
        debugShowCheckedModeBanner: false,
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