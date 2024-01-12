import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app_setup.locator.dart';
import '../core/enums/dialog_type.dart';
import '../ui/dialogs/booking_request_dialog.dart';
import '../ui/dialogs/exit_app.dart';
import '../ui/dialogs/loading_dialog.dart';
import '../ui/dialogs/logout_dialog.dart';
import '../ui/dialogs/notification_details.dart';
import '../ui/dialogs/payment_method_dialog.dart';
import '../ui/dialogs/payment_successful.dart';
import '../ui/dialogs/return_equip_dialog.dart';

void setupDialogUi() {
  var dialogService = locator<DialogService>();
  Map<
      dynamic,
      Widget Function(BuildContext, DialogRequest<dynamic>,
          void Function(DialogResponse<dynamic>))> builders = {
    DialogType.loading: (context, sheetRequest, completer) => LoadingDialog(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.logout: (context, sheetRequest, completer) => LogoutDialog(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.returnEquip: (context, sheetRequest, completer) =>
        ReturnEquipDialog(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.paymentSuccessful: (context, sheetRequest, completer) =>
        PaymentSuccessfulDialog(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.exit: (context, sheetRequest, completer) => ExitApp(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.notification: (context, sheetRequest, completer) =>
        NotificationDetail(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.bookingRequest: (context, sheetRequest, completer) =>
        BookingRequestDialog(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.paymentMethod: (context, sheetRequest, completer) =>
        PaymentMethodDialog(
          request: sheetRequest,
          completer: completer,
        ),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
