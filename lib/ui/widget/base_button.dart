import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../utils/colors.dart';
import '../../utils/text_styles.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool hasBorder;
  final bool isDisabled;
  final Color? borderColor;
  final Color? bgColor;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final String? buttonIcon;
  final bool isBusy;
  const BaseButton(
      {Key? key,
      this.isBusy = false,
      this.borderColor,
      this.buttonIcon,
      this.labelStyle,
      this.onPressed,
      this.labelColor,
      this.bgColor,
      required this.label,
      this.hasBorder = false,
      this.isDisabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      focusElevation: 0,
      highlightElevation: 0,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: hasBorder
              ? BorderSide(color: borderColor ?? AppColors.primaryColor)
              : BorderSide.none),
      onPressed: isDisabled || isBusy ? null : onPressed,
      color: hasBorder ? Colors.transparent : bgColor ?? AppColors.primaryColor,
      disabledColor: hasBorder ? null : AppColors.primaryColor.withOpacity(0.5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: isBusy
          ? Center(
              child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: hasBorder ? AppColors.primaryColor : Colors.white,
                  )))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (buttonIcon != null)
                  Row(
                    children: [
                      SvgPicture.asset(
                        buttonIcon!,
                        color: Colors.white,
                        height: 20,
                      ),
                      Gap(10),
                    ],
                  ),
                Expanded(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: labelStyle ??
                        buttonText.copyWith(
                            color: hasBorder
                                ? borderColor ?? AppColors.primaryColor
                                : labelColor ?? Colors.white),
                  ),
                ),
              ],
            ),
    );
  }
}
