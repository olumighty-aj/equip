import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/enums/theme_modes.dart';

final fontFamily = GoogleFonts.mulish().fontFamily;
final fontFamily2 = GoogleFonts.poppins().fontFamily;

/// Moderate size and weight... Use majorly in Profile screen
TextStyle bodyLarge = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  fontSize: 16,
);

TextStyle displayLarge = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w700,
  fontSize: 36,
);

TextStyle bodyMedium = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: Colors.black,
);

TextStyle bodySmall = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w400,
  fontSize: 12,
  color: Colors.black,
);

TextStyle bodySmaller = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: Colors.black);

TextStyle headingBold = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: AppColors.primaryColor);

/// For buttons... It's white on a green background
TextStyle labelLarge = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w700,
  fontSize: 20,
  color: Colors.white,
  // height: 24 / 16,
);
TextStyle labelMedium = TextStyle(
  fontFamily: fontFamily2,
  fontWeight: FontWeight.w600,
  fontSize: 14,
  color: AppColors.black,
  // height: 24 / 16,
);

TextStyle buttonText = TextStyle(
    fontFamily: fontFamily2,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.white);

TextStyle button2 = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w300,
  fontSize: 12,
  color: Colors.white,
);
TextStyle button3 = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w600,
  fontSize: 13,
  color: Colors.black,
);

/// Slightly bold and small... Use mainly in the starting screens
TextStyle textBody7 = TextStyle(
  fontWeight: FontWeight.w300,
  fontFamily: fontFamily,
  fontSize: 14,
  color: Colors.black,
  height: 23.52 / 14,
);

/// Bold and large...use mainly for price in tags
TextStyle priceStyle = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w500,
  fontSize: 42,
  color: Colors.white,
);

TextStyle appNameStyle = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  fontSize: 36,
  color: AppColors.primaryColor,
);

// TextStyle displayLarge = TextStyle(
//   fontFamily: fontFamily,
//   fontWeight: FontWeight.w600,
//   fontSize: 70,
//   color: Colors.black,
//   // height: 36 / 24,
// );

/// Bold and small... Use for "Poor Network..."
TextStyle displayMedium = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w600,
  fontSize: 24,
  color: Colors.black,
);

/// White and slightly bold... Use for toolbars.
TextStyle displaySmall = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: Colors.white,
);

/// Slightly bold but larger
TextStyle headlineMedium = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w400,
  fontSize: 20,
  color: Colors.black,
  height: 24 / 16,
);

/// Moderate weight and size... Use mainly for navDrawer menuItems
TextStyle headlineSmall = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w600,
  fontSize: 16,
  color: Colors.black,
);

/// Moderate weight, small size... Use
TextStyle titleLarge = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w700,
  fontSize: 20,
  color: Colors.black,
  height: 36 / 20,
);

TextStyle headline6White = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w300,
  fontSize: 12,
  color: Colors.white,
);

TextStyle titleMedium = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w300,
  fontSize: 14,
  height: 21 / 14,
  color: Colors.black,
);
TextStyle textBody5 = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w500,
  fontSize: 12,
  color: Colors.black,
);

/// Deeper Grey
TextStyle titleSmall = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w300,
  fontSize: 14,
  color: Color(0xFF414244),
);

///thicker version of subtitle2
TextStyle subtitle3 = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w300,
  fontSize: 10,
  color: Color(0xFF3F3C40),
);
TextStyle subtitle4 = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w300,
  fontSize: 12,
  color: Color(0x008D8D8E),
);
TextStyle bodyLargeDisplay = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w300,
  fontSize: 40,
  color: Color(0xFF3F3C40),
);
TextStyle numberButton = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.w700,
  fontSize: 32,
  color: Color(0x001B1C1E),
);

final appBarTitleStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

class TextStyles {
  static final fontFamily = GoogleFonts.manrope().fontFamily;

  ThemeModes currentMode = ThemeModes.Light;
  TextTheme textTheme = ThemeData().textTheme;
  AppColors? colors;

  TextStyles(ThemeNotifier themeNotifier) {
    currentMode = themeNotifier.themeMode;
    textTheme = themeNotifier.getTheme().textTheme;
    colors = themeNotifier.colors;
  }

  /// Deeper Grey
  TextStyle get accountFieldText => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w300,
        fontSize: 14,
        color: Color(0xFF000000),
      );
}
