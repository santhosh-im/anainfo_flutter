import 'package:anainfo_flutter/src/modules/home_page.dart';
import 'package:anainfo_flutter/src/modules/leave_page.dart';
import 'package:anainfo_flutter/src/modules/service_page.dart';
import 'package:anainfo_flutter/src/screens/login_screen.dart';
import 'package:anainfo_flutter/src/screens/splash_screen.dart';

import '../modules/about_page.dart';

class PageRoutes{
  static const String splash = SplashScreen.routeName;
  static const String login = LoginScreen.routeName;
  static const String home = HomePage.routeName;
  static const String service = ServicePage.routeName;
  static const String leave = LeavePage.routeName;
  static const String about = AboutPage.routeName;
}