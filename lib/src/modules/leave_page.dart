import 'package:anainfo_flutter/src/utils/constant_dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';
import '../utils/constant_color.dart';
import '../utils/constant_strings.dart';
import '../utils/shared_pref.dart';
import '../widget/nav_drawer.dart';

class LeavePage extends StatefulWidget {
  static const String routeName = '/leavePage';
  final String? restorationId;

  LeavePage({Key? key, this.restorationId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LeavePage();
  }
}

class _LeavePage extends State<LeavePage> with RestorationMixin {
  final _minimumPadding = 10.0;
  String dateTxtHolder = ConstantString.leaveDate;
  TextEditingController mailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  // TODO: implement restorationId
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        dateTxtHolder =
            '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
/*        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));*/
      });
    }
  }

  _submit() async {
    var postData = {
      'email': mailController.text,
      'username': userNameController.text,
      'leavedatefrom': dateController.text,
      'leavedateto': dateController.text,
      'totaldate': dateController.text,
      'reason': reasonController.text,
    };

    print("leaveresponse$postData");
    var res = await Api().postLeave(postData, ConstantString.API_LEAVE);
    print("leaveresponse$res");
    final status = res["status"];

    if (status == ConstantString.SUCCESS) {
    } else {
      showAlertDialog(context, status);
    }
  }

  _submit_new() {
    _formKey.currentState?.reset();
    showAlertDialog(context, "Applied Successfully");
  }

  void _resetData() {
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave"),
      ),
      drawer: NavDrawer(),
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
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(_minimumPadding),
              child: ListView(
                children: [
                  headerField(),
                  mailField(),
                  userNameField(),
                  dateField(),
                  reasonField(),
                  // dateTextField(),
                  submitButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget headerField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: Center(
        child: Expanded(
          child: Text(
            ConstantString.leaveHeading,
            style: TextStyle(
                fontSize: ConstantDimens.twentyFontSize,
                color: ConstantColor.whiteColor),
          ),
        ),
      ));

  Widget dateTextField() => Padding(
        padding: EdgeInsets.all(_minimumPadding),
        child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.all(Radius.circular(5.5))),
            child: GestureDetector(
                child: Text(
                  '$dateTxtHolder',
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                ),
                onTap: () {
                  _restorableDatePickerRouteFuture.present();
                })),
      );

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
          fillColor: Colors.blue.shade100,
          filled: true,
        ),
      ));

  Widget userNameField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return ConstantString.enterUserName;
          }
          return null;
        },
        controller: userNameController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(5.5)),
          hintText: ConstantString.enterUserName,
          hintStyle: TextStyle(color: Colors.black26),
          fillColor: Colors.blue.shade100,
          filled: true,
        ),
      ));

  Widget reasonField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return ConstantString.leaveReason;
          }
          return null;
        },
        controller: reasonController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(5.5)),
          hintText: ConstantString.leaveReason,
          hintStyle: TextStyle(color: Colors.black26),
          fillColor: Colors.blue.shade100,
          filled: true,
        ),
      ));

  Widget dateField() => Padding(
      padding: EdgeInsets.all(_minimumPadding),
      child: GestureDetector(
        child: TextFormField(
          // readOnly: true,
          // enabled: false,
          validator: (String? value) {
            if (value!.isEmpty) {
              return ConstantString.leaveDate;
            }
            return null;
          },
          controller: dateController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: ConstantString.leaveDate,
            hintStyle: TextStyle(color: Colors.black26),
            fillColor: Colors.blue.shade100,
            filled: true,
          ),
        ),
        onTap: () {
          _restorableDatePickerRouteFuture.present();
        },
      ));

  Widget submitButton() => Padding(
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
                child: Text(ConstantString.submit),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // _submit();
                    _submit_new();
                  }
                },
              ),
            )),
          ],
        ),
      );

  void showAlertDialog(BuildContext context, String content) {
    Widget okBtn = TextButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
        child: Text("Ok"));

    var alertDialog = AlertDialog(
      title: Text("Success"),
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
}
