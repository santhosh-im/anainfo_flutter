import 'package:anainfo_flutter/src/api/api.dart';
import 'package:anainfo_flutter/src/screens/login_screen.dart';
import 'package:anainfo_flutter/src/screens/new_login.dart';
import 'package:anainfo_flutter/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import '../modules/home_page.dart';
import '../utils/constant_color.dart';
import '../utils/constant_strings.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupScreen();
  }
}

class _SignupScreen extends State<SignupScreen> {
  final _minimumPadding = 10.0;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController altPhoneController = TextEditingController();
  TextEditingController offMailController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  _signup() async {
    var signupData = {
      'Firstname': firstNameController.text,
      'Lastname': lastNameController.text,
      'email': mailController.text,
      'password': passwordController.text,
      'Phonenumber': phoneController.text,
      'Alternativenumber': altPhoneController.text,
      'OfficialId': offMailController.text,
      'Designation': designationController.text,
      'Experience': experienceController.text,
    };
    var res = await Api().postSignup(signupData, ConstantString.API_SIGNUP);
    print("signupresponse$res");
    final status = res["message"];
    if (status == "Email is registered successfully") {
      SharedPref.instance.setBooleanValue("loggedin", true);

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
                  firstNameField(),
                  lastNameField(),
                  mailField(),
                  passwordField(),
                  phoneField(),
                  altPhoneField(),
                  offMailField(),
                  designationField(),
                  experienceField(),
                  signButton(),
                  Padding(
                      padding: EdgeInsets.all(_minimumPadding),
                      child: Center(
                        child: GestureDetector(
                          child: Expanded(
                            child: Text(
                              ConstantString.signupDesc,
                              style:
                                  TextStyle(color: Colors.blueAccent.shade200),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()));
                          },
                        ),
                      ))
                ],
              )),
        ),
      ),
    ));
  }

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

  Widget firstNameField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return ConstantString.enterFirstName;
          }
          return null;
        },
        controller: firstNameController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: ConstantString.enterFirstName,
            hintStyle: TextStyle(color: Colors.black26),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              Icons.person,
              color: Colors.black12,
            )),
      ));

  Widget lastNameField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return ConstantString.enterLastname;
          }
          return null;
        },
        controller: lastNameController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: ConstantString.enterLastname,
            hintStyle: TextStyle(color: Colors.black26),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              Icons.person,
              color: Colors.black12,
            )),
      ));

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

  Widget phoneField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return ConstantString.enterPhoneNumber;
          }
          return null;
        },
        keyboardType: TextInputType.number,
        controller: phoneController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: ConstantString.enterPhoneNumber,
            hintStyle: TextStyle(color: Colors.black26),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.black12,
            )),
      ));

  Widget altPhoneField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return ConstantString.enterAlternativePhoneNumber;
          }
          return null;
        },
        keyboardType: TextInputType.number,
        controller: altPhoneController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: ConstantString.enterAlternativePhoneNumber,
            hintStyle: TextStyle(color: Colors.black26),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.black12,
            )),
      ));

  Widget offMailField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return ConstantString.enterOfficialMail;
          }
          return null;
        },
        controller: offMailController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: ConstantString.enterOfficialMail,
            hintStyle: TextStyle(color: Colors.black26),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              Icons.mail,
              color: Colors.black12,
            )),
      ));

  Widget designationField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return ConstantString.enterDesignation;
          }
          return null;
        },
        controller: designationController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: ConstantString.enterDesignation,
            hintStyle: TextStyle(color: Colors.black26),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              Icons.work,
              color: Colors.black12,
            )),
      ));

  Widget experienceField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return ConstantString.enterExperience;
          }
          return null;
        },
        controller: experienceController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: ConstantString.enterExperience,
            hintStyle: TextStyle(color: Colors.black26),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              Icons.work_sharp,
              color: Colors.black12,
            )),
      ));

  Widget signButton() => Padding(
        padding: EdgeInsets.all(_minimumPadding),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    child: Text(ConstantString.signup),
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          _signup();
                        }
                      });
                    },
                  )),
            ),
          ],
        ),
      );
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
