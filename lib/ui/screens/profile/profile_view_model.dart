import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/base_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class ProfileViewModel extends BaseModel {
  final Authentication _authentication = locator<Authentication>();
  final NavigationService _navigationService = locator<NavigationService>();

  editProfile(
    String displayPicture,
    String address,
    String fullName,
    String phone,
    String lat,
    String lng,
  ) async {
    setBusy(true);
    var result = await _authentication.editProfile(
      displayPicture,
      address,
      fullName,
      phone,
      lat,
      lng,
    );
    if (result == null) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return result;
    }
    setBusy(false);
     _navigationService.pushAndRemoveUntil(HomeOwnerRoute);
    notifyListeners();
    return result;
  }
}
