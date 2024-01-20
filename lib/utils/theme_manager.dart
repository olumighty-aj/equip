import 'package:equipro/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/services/shared_prefs.dart';
import '../core/enums/theme_modes.dart';
import 'colors.dart';
import 'dimensions.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    fontFamily: TextStyles.fontFamily,
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: Color(0xFF1B1C1E),
      titleTextStyle:
          titleMedium.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    textTheme: TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        headlineLarge: headingBold,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium),
  );

  final lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
    fontFamily: TextStyles.fontFamily,
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.white,
    ),
    drawerTheme: const DrawerThemeData(scrimColor: Colors.black),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: IconThemeData(color: Colors.black),
      scrolledUnderElevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Color(0xFF1B1C1E), fontSize: 20, fontWeight: FontWeight.w400),
    ),
    textTheme: TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineMedium: headlineMedium,
        headlineLarge: headingBold,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium),
  );

  ThemeData _themeData = ThemeData();
  ThemeData getTheme() => lightTheme; // _themeData;

  ThemeModes _themeMode = ThemeModes.Light;

  ThemeModes get themeMode => _themeMode;

  TextStyles get textStyles => TextStyles(this);
  AppColors get colors => AppColors(this);
  Dimen get dimens => Dimen(this);

  ThemeNotifier() {
    SharedPrefsClient.readData('themeMode').then((value) {
      print('value read from storage: $value');
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        setLightMode();
      } else {
        setDarkMode();
      }
      notifyListeners();
    });
  }

  bool get isInLightMode => _themeMode == ThemeModes.Light;

  void setDarkMode() async {
    _themeData = darkTheme;
    _themeMode = ThemeModes.Dark;
    notifyListeners();
    SharedPrefsClient.saveData('themeMode', 'dark');
  }

  void setLightMode() async {
    _themeData = lightTheme;
    _themeMode = ThemeModes.Light;
    notifyListeners();
    SharedPrefsClient.saveData('themeMode', 'light');
  }

  void switchMode() async {
    isInLightMode ? setDarkMode() : setLightMode();
  }
}

extension Conv on ThemeModes {
  String string() {
    return toString().split('.').last;
  }
}

extension Con on String {
  ThemeModes toThemeMode() {
    for (ThemeModes type in ThemeModes.values) {
      if (type.string() == this) return type;
    }
    return ThemeModes.Light;
  }
}
