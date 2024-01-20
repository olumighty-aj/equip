import 'dart:convert';

import 'package:equipro/core/api/dio_service.dart';
import 'package:equipro/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// import 'package:flutter_stripe/flutter_stripe.dart';

import '../core/services/auth_service.dart';
import '../core/services/shared_prefs.dart';
import '../setup/setup_bottomsheet_ui.dart';
import '../setup/setup_dialog_ui.dart';
import '../setup/setup_snackbar_ui.dart';
import 'app_setup.locator.dart';

class App {
  static Future initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.onBackgroundMessage(
        (message) async => messageHandler(message));
    // Stripe.publishableKey =
    //     'pk_live_51NEXPyGOYHh4f2GJ0KXCJJQQbWJRfXN1hCQzdrNuAzXOgFZ3bzMzYdMHB8qO8r2ekXUgFy18QlSzNiJ3bLdJxRkW00xzECKDuM';
    // Stripe.merchantIdentifier = 'any string works';
    // await Stripe.instance.applySettings();
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

  static Future<bool> checkIfTokenExists() async {
    bool tokenExists = await SharedPrefsClient.checkData("token");
    if (tokenExists) {
      return true;
    } else {
      return false;
    }
  }

  static checkIfIsHirer() async {
    bool isDetails = await SharedPrefsClient.checkData("currentUser");
    if (isDetails) {
      var details = jsonDecode(await SharedPrefsClient.readData("currentUser"));
      if (await checkIfTokenExists()) {
        String? token = await SharedPrefsClient.readData("token");
        locator<ApiService>().setAccessToken(token);
        if (details["user_type"] == "hirers") {
          return true;
        } else {
          return false;
        }
      }
      // if (token == null) {
      //   print("Token: $token");
      //   return false;
      // }
    }
  }
}
