import 'dart:convert';
import 'dart:io';

import 'package:equipro/core/api/dio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../core/services/auth_service.dart';
import '../core/services/shared_prefs.dart';
import '../setup/setup_bottomsheet_ui.dart';
import '../setup/setup_dialog_ui.dart';
import '../setup/setup_snackbar_ui.dart';
import 'app_setup.locator.dart';
import 'app_setup.router.dart';

class App {
  static Future initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    Stripe.publishableKey =
        'pk_live_51NEXPyGOYHh4f2GJ0KXCJJQQbWJRfXN1hCQzdrNuAzXOgFZ3bzMzYdMHB8qO8r2ekXUgFy18QlSzNiJ3bLdJxRkW00xzECKDuM';
    Stripe.merchantIdentifier = 'any string works';
    await Stripe.instance.applySettings();
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    setupLocator();
    setupBottomSheetUi();
    setupDialogUi();
    setupSnackBarUi();
  }
  // String? initialRoute = Routes.onboardingScreen;

  static checkIfUserIsNew() async {
    bool userExists = await SharedPrefsClient.checkData("currentUser");
    if (userExists) {
      print(userExists);
      // initialRoute = Routes.login;
      // print(initialRoute);
      locator<Authentication>().setCurrentUser(
          jsonDecode(await SharedPrefsClient.readData("currentUser")));
      return true;
    } else {
      return false;
    }
  }

  static checkIfIsHirer() async {
    var details = jsonDecode(await SharedPrefsClient.readData("currentUser"));
    String token = await SharedPrefsClient.readData("token");
    locator<ApiService>().setAccessToken(token);
    if (details["user_type"] == "hirers") {
      return true;
    } else {
      return false;
    }
  }
}
