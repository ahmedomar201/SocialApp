import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20,
      ),
      child: Container(
        width: double.infinity,
        height: 5,
        color: Colors.grey[300],
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    Container(
      width: double.infinity,
      color: Colors.blue,
      child: MaterialButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: choseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

//enum
enum ToastStates { SUCCESS, ERROR, WARING }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARING:
      color = Colors.amber;
      break;
  }
  return color;
}


void printFullText(String text) {
  final pattern = RegExp('.{1.800}'); //80is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

// String? token = '';

String? uId = '';

AppBar defaultAppBar({
  required BuildContext context,
  String? title,
  final List<Widget>?actions,
})=>AppBar(
  leading: IconButton(
    onPressed:()
    {
      Navigator.pop(context);
    },
    icon:Icon(
      IconBroken.Arrow___Left_2 ,
    ),
  ),
  title: Text(title!),
  actions: actions,

);