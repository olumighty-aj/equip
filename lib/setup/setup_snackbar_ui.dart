import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app_setup.locator.dart';
import '../core/enums/snackbar_type.dart';

void setupSnackBarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackBar
  service.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: Colors.white,
    messageColor: Colors.red,
    margin: EdgeInsets.all(8.0),
    borderRadius: 8.0,
    animationDuration: const Duration(seconds: 1),
    boxShadows: [
      BoxShadow(
        color: Colors.grey.shade300,
        offset: Offset(0, -2),
        blurRadius: 1.0,
      )
    ],
  ));

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.errorMessage,
    config: SnackbarConfig(
      titleTextAlign: TextAlign.center,
      messageTextAlign: TextAlign.center,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade700,
      textColor: Colors.white,
      margin: EdgeInsets.zero,
      messageColor: Colors.white,
      titleColor: Colors.white,
      // borderRadius: 10,
      dismissDirection: DismissDirection.horizontal,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.successMessage,
    config: SnackbarConfig(
      titleTextAlign: TextAlign.center,
      messageTextAlign: TextAlign.center,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade700,
      textColor: Colors.white,
      margin: EdgeInsets.zero,
      messageColor: Colors.white,
      titleColor: Colors.white,
      // borderRadius: 10,
      dismissDirection: DismissDirection.horizontal,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.warningMessage,
    config: SnackbarConfig(
      titleTextAlign: TextAlign.center,
      messageTextAlign: TextAlign.center,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.yellow.shade800,
      textColor: Colors.white,
      margin: EdgeInsets.zero,
      messageColor: Colors.white,
      titleColor: Colors.white,
      // borderRadius: 10,
      dismissDirection: DismissDirection.horizontal,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.greenAndRed,
    config: SnackbarConfig(
      backgroundColor: Colors.white,
      titleColor: Colors.green,
      messageColor: Colors.red,
      borderRadius: 1,
    ),
  );
}
