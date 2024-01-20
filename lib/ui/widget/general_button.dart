import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  final Function onPressed;
  final BorderRadius borderRadius;
  final Color borderColor;
  final Color splashColor;
  final String buttonText;
  final Color buttonTextColor;
  GeneralButton({
    required this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.splashColor = AppColors.primaryColor,
    required this.buttonText,
    this.buttonTextColor = const Color(0xffFFFFFF),
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        height: 50,
        width: deviceWidth,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: splashColor,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
                side: BorderSide(color: borderColor),
              )),
          onPressed: () {
            onPressed();
          },
          child: Text(
            buttonText,
            style: TextStyle(
              color: buttonTextColor,
              fontWeight: FontWeight.w500,
              //fontSize: 15
            ),
          ),
        ));
  }
}
