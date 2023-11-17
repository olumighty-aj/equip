import 'package:flutter/material.dart';

import 'theme_manager.dart';

class Dimen {
  static const double roundButtonRadius = 12.0;
  static const double defaultIntraColumnSpacing = 8.0;
  static const double bottomSheetCornerRadius = 36.0;
  static const double roundedFieldRadius = 40.0;

  // FontSizes
  static const double bodyTextSize = 16.0;

  // spacing
  static const double smallHeight = 8;
  static const double smallWidth = 8;
  static const double mediumHeight = 16;
  static const double mediumWeight = 16;
  static const double bigHeight = 32;
  static const double bigWidth = 32;
  static const double largeHeight = 50;
  static const double largeWidth = 50;

  // Constants

  static const EdgeInsets bodyPadding = EdgeInsets.symmetric(
    vertical: 20,
    horizontal: 20,
  );

  static const EdgeInsets screenPadding = EdgeInsets.all(16);

  ThemeData theme = ThemeData();

  Dimen(ThemeNotifier themeNotifier) {
    theme = themeNotifier.getTheme();
  }
}
