import 'package:anainfo_flutter/src/api/api.dart';
import 'package:anainfo_flutter/src/screens/new_login.dart';
import 'package:anainfo_flutter/src/screens/signup_screen.dart';
import 'package:anainfo_flutter/src/utils/constant_color.dart';
import 'package:anainfo_flutter/src/utils/constant_strings.dart';
import 'package:anainfo_flutter/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import '../modules/home_page.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/loginPage';

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final _minimumPadding = 10.0;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  _login() async {
    var loginData = {
      'email': mailController.text,
      'password': passwordController.text
    };
    var res = await Api().postLogin(loginData, ConstantString.API_LOGIN);
    print("loginresponse$res");
    final status = res["status"];

    if (status == ConstantString.SUCCESS) {
      final email = res["email"];
      final Firstname = res["Firstname"];
      SharedPref.instance.setBooleanValue(ConstantString.IS_LOGGED, true);
      SharedPref.instance.setStringValue(ConstantString.USER_MAIL, email);
      SharedPref.instance.setStringValue(ConstantString.USER_NAME, Firstname);
      SharedPref.instance.setStringValue(ConstantString.USER_FIRST_LETTER, Firstname);
      Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    } else {
      showAlertDialog(context, status);
    }
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
              ConstantColor.bgGradientStart,
              ConstantColor.bgGradientEnd
            ])),
        child: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.all(_minimumPadding),
              child: ListView(
                children: <Widget>[
                  getImage(),
                  mailField(),
                  passwordField(),
                  loginButton(),
                  Padding(
                      padding: EdgeInsets.all(_minimumPadding),
                      child: Center(
                        child: GestureDetector(
                          child: Expanded(
                            child: Text(
                              ConstantString.loginDesc,
                              style:
                                  TextStyle(color: Colors.blueAccent.shade200),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignupScreen()));
                          },
                        ),
                      ))
                ],
              )),
        ),
      ),
    ));
  }

  Widget mailField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return ConstantString.enterMail;
          }
          return null;
        },
        controller: mailController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: ConstantString.enterMail,
            hintStyle: TextStyle(color: Colors.black26),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              Icons.mail,
              color: Colors.black12,
            )),
      ));

  Widget passwordField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return ConstantString.enterPassword;
          }
          return null;
        },
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: ConstantString.enterPassword,
            hintStyle: TextStyle(color: Colors.black26),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.black12,
            )),
      ));

  Widget loginButton() => Padding(
        padding: EdgeInsets.all(_minimumPadding),
        child: Row(
          children: [
            Expanded(
                child: Container(
              height: 50,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    onPrimary: Colors.white,
                    shadowColor: Colors.blue,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                child: Text(ConstantString.login),
                onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                },
              ),
            )),
/*
                      Expanded(
                          child: ElevatedButton(
                        child: Text("newLogin"),
                        onPressed: () {
                          setState(() {
                            Navigator.pushAndRemoveUntil(
                                context,
                                new MaterialPageRoute(builder: (context) => NewLogin()),
                                    (Route<dynamic> route) => false);
                          });
                        },
                      ))
*/
          ],
        ),
      );

  Widget getImage() {
    AssetImage assetImage = AssetImage("assets/images/app_logo.png");
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
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: Text("Ok"));

  var alertDialog = AlertDialog(
    title: Text("Alert"),
    content: Text(content),
    actions: [
      okBtn,
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}
