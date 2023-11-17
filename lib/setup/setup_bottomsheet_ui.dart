import 'package:flutter/material.dart';

import 'package:stacked_services/stacked_services.dart';

import '../../app/app_setup.locator.dart';
import '../core/enums/bottom_sheet_type.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  Map<
      dynamic,
      Widget Function(BuildContext, SheetRequest<dynamic>,
          void Function(SheetResponse<dynamic>))> builders = {};

  bottomSheetService.setCustomSheetBuilders(builders);
}
