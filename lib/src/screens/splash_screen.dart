import 'package:anainfo_flutter/src/utils/constant_color.dart';
import 'package:anainfo_flutter/src/utils/constant_strings.dart';
import 'package:anainfo_flutter/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import '../modules/home_page.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splashPage';
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    initShared();
    debugPrint("islogged$isLoggedIn.toString()");
    Future.delayed(const Duration(seconds: 3)).then((value) => {
          if (isLoggedIn)
            {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                  (route) => false)
            }
          else
            {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false)
            }
        });
  }

  void initShared() {
    SharedPref.instance
        .getBooleanValue(ConstantString.IS_LOGGED)
        .then((value) => setState(() {
              isLoggedIn = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                ConstantColor.gradientStart,
                ConstantColor.gradientEnd,
              ])),
          child: Center(
            child: Image.asset(
              "assets/images/app_logo.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
