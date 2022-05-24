import 'package:anainfo_flutter/src/screens/new_login.dart';
import 'package:anainfo_flutter/src/utils/constant_strings.dart';
import 'package:anainfo_flutter/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import '../utils/constant_color.dart';
import '../widget/nav_drawer.dart';
import '../screens/login_screen.dart';
import '../widget/stacked_card_demo.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homePage';

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  final _minimumPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              ConstantColor.bgGradientStart,
              ConstantColor.bgGradientEnd
            ])),
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding),
          child: ListView(
            children: [
              getImage(),
              Padding(
                padding: EdgeInsets.all(_minimumPadding),
                child: Expanded(
                  child: Text(
                    ConstantString.homeInfoFirst,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minimumPadding),
                child: Expanded(
                  child: GestureDetector(
                   child: Text(
                     ConstantString.homeInfoSecond,
                     style: TextStyle(fontSize: 20.0, color: Colors.white),
                   ),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyStatefulWidget()));
                    },
                  )

                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minimumPadding),
                child: getBannerImage(),
              )
            ],
          ),
        ),
      )),
      drawer: NavDrawer(),
    );
  }

  Widget getImage() {
    AssetImage assetImage = AssetImage("assets/images/banner_logo.png");
    Image image = Image(
      image: assetImage,
      width: 150.0,
      height: 150.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(20.0),
    );
  }

  Widget getBannerImage() {
    AssetImage assetImage = AssetImage("assets/images/app_banner.png");
    Image image = Image(
      image: assetImage,
      width: 150.0,
      height: 150.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(20.0),
    );
  }
}

void showAlertDialog(BuildContext context, String content) {
  Widget okBtn = TextButton(
      onPressed: () {
        SharedPref.instance.removeAll();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      },
      child: Text("Ok"));
  Widget cancelBtn = TextButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: Text("Cancel"));

  var alertDialog = AlertDialog(
    title: Text("Alert"),
    content: Text(content),
    actions: [
      okBtn,
      cancelBtn,
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}
