import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast({
  String type,
  @required String message,
}) {
  // Toast.show(
  //   message,
  //   context,
  //   duration: Toast.LENGTH_LONG,
  //   gravity: Toast.BOTTOM,
  //   backgroundColor: type == 'error' ? Colors.red : Colors.green,
  //   textColor: Colors.white,
  // );

  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: type == 'error' ? Colors.red : Colors.green,
    textColor: Colors.white,
  );
}
