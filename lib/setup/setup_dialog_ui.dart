import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app_setup.locator.dart';
import '../core/enums/dialog_type.dart';
import '../ui/dialogs/exit_app.dart';
import '../ui/dialogs/loading_dialog.dart';
import '../ui/dialogs/logout_dialog.dart';

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
    DialogType.exit: (context, sheetRequest, completer) => ExitApp(
          request: sheetRequest,
          completer: completer,
        ),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
