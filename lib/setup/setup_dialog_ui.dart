import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app_setup.locator.dart';
import '../core/enums/dialog_type.dart';

void setupDialogUi() {
  var dialogService = locator<DialogService>();
  Map<
      dynamic,
      Widget Function(BuildContext, DialogRequest<dynamic>,
          void Function(DialogResponse<dynamic>))> builders = {};

  dialogService.registerCustomDialogBuilders(builders);
}
