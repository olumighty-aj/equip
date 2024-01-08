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
    BaseDataModel? model = await _user
        .updateNotificationSettings(isNotificationEnabled ? "1" : "0");
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
    BaseDataModel? res = await _activities.getSettings();
    if (res?.status == true) {
      _log.i(res?.toJson());
    } else {
      _log.e(res?.toJson());
    }
  }

  void changeProfileVisibilityState(val, context) async {
    BaseDataModel? model =
        await _user.updateProfileVisibility(isProfileVisible ? "1" : "0");
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
}
