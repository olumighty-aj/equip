import 'package:equipro/app/app_setup.locator.dart';
import 'package:equipro/core/model/base_model.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.logger.dart';
import '../../../core/services/activities_service.dart';

class SettingsViewModel extends BaseViewModel {
  final _log = getLogger("Settings");
  final _user = locator<Authentication>();
  final _activities = locator<Activities>();
  bool isNotificationEnabled = true;
  bool isProfileVisible = true;

  void changeNotificationState(val, context) async {
    BaseDataModel? model =
        await _user.updateNotificationSettings(val ? "1" : "0");
    if (model?.status == true) {
      isNotificationEnabled = val;
      notifyListeners();
      showToast(model?.message ?? "Notification update successful",
          context: context);
    } else {
      showErrorToast(model?.message ?? "Notification update failed",
          context: context);
    }
  }

  void getSettings() async {
    BaseDataModel? res =
        await runBusyFuture(_activities.getSettings(), busyObject: "settings");
    if (res?.status == true) {
      _log.i(res?.toJson());
      isProfileVisible = setTrueFalse(res!.payload["profile_visibility"]);
      isNotificationEnabled = setTrueFalse(res.payload["notification"]);
      notifyListeners();
    } else {
      _log.e(res?.toJson());
    }
  }

  void changeProfileVisibilityState(val, context) async {
    BaseDataModel? model = await _user.updateProfileVisibility(val ? "1" : "0");
    if (model?.status == true) {
      isProfileVisible = val;
      notifyListeners();
      showToast(model?.message ?? "Profile update successful",
          context: context);
    } else {
      showErrorToast(model?.message ?? "Profile update failed",
          context: context);
    }
  }

  setTrueFalse(String num) {
    switch (num) {
      case "0":
        return false;
      case "1":
        return true;
      default:
        return false;
    }
  }
}
