import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Util{
  static displayToastMessage(String message, BuildContext context){
    Fluttertoast.showToast(msg: message);
  }
}