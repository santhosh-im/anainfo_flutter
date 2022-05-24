import 'package:anainfo_flutter/src/modules/about_page.dart';
import 'package:anainfo_flutter/src/modules/home_page.dart';
import 'package:anainfo_flutter/src/modules/leave_page.dart';
import 'package:anainfo_flutter/src/modules/service_page.dart';
import 'package:anainfo_flutter/src/routes/page_routes.dart';
import 'package:anainfo_flutter/src/screens/login_screen.dart';
import 'package:anainfo_flutter/src/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        PageRoutes.home:(context) => HomePage(),
        PageRoutes.service:(context) => ServicePage(),
        PageRoutes.leave:(context) => LeavePage(),
        PageRoutes.about:(context) => AboutPage(),
      },
    );
  }
}
