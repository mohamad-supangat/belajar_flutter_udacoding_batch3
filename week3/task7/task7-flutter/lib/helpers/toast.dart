import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void $toast({
  String type,
  String message,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: type == 'error' ? Colors.red : Colors.green,
    textColor: Colors.white,
  );
}
