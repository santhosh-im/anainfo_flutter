import 'package:anainfo_flutter/src/routes/page_routes.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../utils/constant_strings.dart';
import '../utils/shared_pref.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NavDrawer();
  }
}

class _NavDrawer extends State<NavDrawer> {
  String? userName;
  String? userMail;
  String? firstLetterTxt;

  @override
  void initState() {
    super.initState();
    initShared();
  }

  void initShared() {
    SharedPref.instance
        .getStringValue(ConstantString.USER_NAME)
        .then((value) => setState(() {
              userName = value;
            }));
    SharedPref.instance
        .getStringValue(ConstantString.USER_MAIL)
        .then((value) => setState(() {
              userMail = value;
            }));
    SharedPref.instance
        .getStringValue(ConstantString.USER_FIRST_LETTER)
        .then((value) => setState(() {
              firstLetterTxt = captialize(value);
            }));
  }

  String captialize(String str) {
    if (str == null || str.isEmpty) {
      return str;
    }
    return str.length < 1 ? str.toUpperCase() : str[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // padding: EdgeInsets.all(_padding),
        children: [
          navigationHeader(),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text("Home"),
            onTap: () {
              Navigator.pushReplacementNamed(context, PageRoutes.home);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Service"),
            onTap: () {
              Navigator.pushReplacementNamed(context, PageRoutes.service);
            },
          ),
          ListTile(
            leading: Icon(Icons.alarm_add_sharp),
            title: Text("Leave"),
            onTap: () {
              Navigator.pushReplacementNamed(context, PageRoutes.leave);
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text("About"),
            onTap: () {
              Navigator.pushReplacementNamed(context, PageRoutes.about);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              showAlertDialog(context, "Are you sure want to logout");
            },
          )
        ],
      ),
    );
  }

  Widget navigationHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(userName!),
      accountEmail: Text(userMail!),
      decoration: BoxDecoration(color: Colors.blueAccent),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.purple,
        child: Text(
          firstLetterTxt!,
          style: TextStyle(
            fontSize: 35.0,
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context, String content) {
  Widget okBtn = TextButton(
      onPressed: () {
        SharedPref.instance.removeAll();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
            (route) => false);
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
