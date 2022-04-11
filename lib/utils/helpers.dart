import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:equipro/utils/colors.dart';

customYMargin(double value) {
  return SizedBox(height: value);
}

customXMargin(double value) {
  return SizedBox(width: value);
}

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      webPosition: "center",
      timeInSecForIosWeb: 5,
      backgroundColor: AppColors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

showErrorToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      webPosition: "center",
      webBgColor: "#e74c3c",
      timeInSecForIosWeb: 5,
      // backgroundColor: AppColors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

String capitalize(val) {
  return "${val[0].toUpperCase()}${val.substring(1)}";
}

formatDate(value) {
  final df = new DateFormat('dd-MM-yyyy');
  return df.format(DateTime.parse(value));
}

formatDateTime(value) {
  final df = new DateFormat('d MMMM, y hh:mm a');
  return df.format(DateTime.parse(value));
}

class Status {
  static final sent = 'sent';
  static final delivered = 'delivered';
  static final read = 'read';
}

//Sanni height sizer
height(double value, BuildContext context) {
  return MediaQuery.of(context).size.height * value;
}

width(double value, BuildContext context) {
  return MediaQuery.of(context).size.width * value;
}

class Validators {
  String? isEmpty(value) {
    if (value.isEmpty) {
      return 'Empty field';
    } else {
      return null;
    }
  }

  String? isPassword(value) {
    if (value.isEmpty) {
      return 'Empty field';
    }else if (validateStructure(value)){
      return null;
    }else{
      return 'Password should contain At least one upper case letter.\nPassword should contain At least one numeric value.\nPassword should contain At least one special case characters';
    }

  }

  String? isEmail(value) {
    if (value.isEmpty) {
      return 'Empty field';
    }else if (validateEmail(value)){
      return null;
    }else{
      return 'Invalid email';
    }

  }
  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp =  RegExp(pattern);
    return regExp.hasMatch(value);
  }
   bool validateEmail (String value) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

}