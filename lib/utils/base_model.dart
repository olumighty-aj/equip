// import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/progressBarManager/dialog_models.dart';
import 'package:equipro/utils/progressBarManager/dialog_service.dart';
import 'package:flutter/widgets.dart';

import '../app/app_setup.locator.dart';

class BaseModel extends ChangeNotifier {
  //final Authentication _authenticationService = locator<Authentication>();
  final ProgressService _dialogService = locator<ProgressService>();
  late ProgressResponse hh;
  // Data get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
    if (value == true) {
      _dialogService.showDialog(description: '', title: '');
    } else {
      _dialogService.dialogComplete();
    }
  }
}

mixin BusyMixin on ChangeNotifier {
  final ProgressService dialogService = locator<ProgressService>();
  bool _loading = false;
  bool get loading => _loading;

  void setBusy(bool value) {
    _loading = value;
    notifyListeners();
    if (value == true) {
      dialogService.showDialog(description: '', title: '');
    } else {
      dialogService.dialogComplete();
    }
  }
}
