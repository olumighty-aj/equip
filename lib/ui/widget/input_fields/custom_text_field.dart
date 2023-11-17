import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final String? hintText;
  final bool hasBorder;
  final Color? borderColor;
  final Color? fillColor;
  final Widget? prefixIcon;
  final String? label;
  final Color? labelColor;
  final int minLines;
  final int maxLines;
  final Widget? suffixIcon;
  final Widget? suffix;
  final int? maxLength;
  final String? Function(dynamic)? validator;
  final void Function()? onTap;
  final bool isEnabled;
  final BoxConstraints? suffixConstraints;
  final TextInputType? keyboardType;
  const CustomTextField(
      {Key? key,
      this.labelColor,
      this.suffix,
      this.onTap,
      this.suffixConstraints,
      this.hintText,
      this.keyboardType,
      this.validator,
      this.maxLength,
      this.minLines = 1,
      this.maxLines = 1,
      this.suffixIcon,
      this.controller,
      this.label,
      this.prefixIcon,
      this.onChanged,
      this.borderColor,
      this.fillColor,
      this.isEnabled = true,
      this.hasBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Column(
            children: [
              Text(
                label!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400, color: labelColor),
              ),
              Gap(5)
            ],
          ),
        TextFormField(
          validator: validator,
          keyboardType: keyboardType,
          maxLength: maxLength,
          enabled: isEnabled,
          controller: controller,
          onTap: onTap,
          minLines: minLines,
          onChanged: onChanged,
          maxLines: maxLines,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              fillColor: fillColor ?? AppColors.primaryColor.withOpacity(0.3),
              border: hasBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: borderColor ?? AppColors.primaryColor),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
              enabledBorder: hasBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: borderColor ?? AppColors.primaryColor),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
              focusedBorder: hasBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: borderColor ?? AppColors.primaryColor),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
              hintText: hintText,
              filled: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: prefixIcon,
              ),
              suffix: suffix,
              suffixIconConstraints:
                  suffixConstraints ?? BoxConstraints.loose(Size(40, 40)),
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: suffixIcon,
              ),
              prefixIconConstraints: BoxConstraints.loose(Size(40, 40)),
              prefixIconColor: Colors.black),
        ),
      ],
    );
  }
}

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final String? hintText;
  final bool hasBorder;
  final Color? borderColor;
  final Color? fillColor;
  final Widget? prefixIcon;
  final String? label;
  final Color? labelColor;
  final int minLines;
  final int maxLines;
  final Widget? suffixIcon;
  final Widget? suffix;
  final int? maxLength;
  final String? Function(dynamic)? validator;
  final void Function()? onTap;
  final bool isEnabled;
  final BoxConstraints? suffixConstraints;
  final TextInputType? keyboardType;
  const CustomSearchField(
      {Key? key,
      this.labelColor,
      this.suffix,
      this.onTap,
      this.suffixConstraints,
      this.hintText,
      this.keyboardType,
      this.validator,
      this.maxLength,
      this.minLines = 1,
      this.maxLines = 1,
      this.suffixIcon,
      this.controller,
      this.label,
      this.prefixIcon,
      this.onChanged,
      this.borderColor,
      this.fillColor,
      this.isEnabled = true,
      this.hasBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Column(
            children: [
              Text(
                label!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400, color: labelColor),
              ),
              Gap(5)
            ],
          ),
        TextFormField(
          validator: validator,
          keyboardType: keyboardType,
          maxLength: maxLength,
          enabled: isEnabled,
          controller: controller,
          onTap: onTap,
          minLines: minLines,
          onChanged: onChanged,
          maxLines: maxLines,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey),
              ),
              hintText: hintText,
              // filled: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.search_outlined,
                  color: Colors.grey,
                ),
              ),
              suffix: suffix,
              suffixIconConstraints:
                  suffixConstraints ?? BoxConstraints.loose(Size(40, 40)),
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: suffixIcon,
              ),
              prefixIconConstraints: BoxConstraints.loose(Size(40, 40)),
              prefixIconColor: Colors.black),
        ),
      ],
    );
  }
}

// https://meet.google.com/xzh-dsom-qzt
