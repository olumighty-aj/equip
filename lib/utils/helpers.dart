import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

customYMargin(double value) {
  return SizedBox(height: value);
}

customXMargin(double value) {
  return SizedBox(width: value);
}

showToast(String message, {context}) {
  return showTopSnackBar(
    context,
    CustomSnackBar.success(
      backgroundColor: AppColors.green,
      message: message,
      textStyle:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
    ),
  );
}

showErrorToast(String message, {context}) {
  return showTopSnackBar(
    context,
    CustomSnackBar.info(
      backgroundColor: AppColors.red,
      message: message,
      textStyle:
          Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
    ),
  );
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
    } else if (validateStructure(value)) {
      return null;
    } else {
      return 'Password should contain At least one upper case letter.\nPassword should contain At least one numeric value.\nPassword should contain At least one special case characters';
    }
  }

  String? isEmail(value) {
    if (value.isEmpty) {
      return 'Empty field';
    } else if (validateEmail(value)) {
      return null;
    } else {
      return 'Invalid email';
    }
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}

widthSizer(double value, BuildContext context, {figmaWidth = 414}) {
  // 414 is the default design screen width on figma
  return MediaQuery.of(context).size.width *
      (value / figmaWidth); // width size on figma
}

heightSizer(double value, BuildContext context, {figmaHeight = 896}) {
  // 896 is the default design screen height on figma
  return MediaQuery.of(context).size.height *
      (value / figmaHeight); // height size on figma
}
