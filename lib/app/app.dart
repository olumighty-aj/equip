import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../setup/setup_bottomsheet_ui.dart';
import '../setup/setup_dialog_ui.dart';
import '../setup/setup_snackbar_ui.dart';
import 'app_setup.locator.dart';

class App {
  static Future initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
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
}
