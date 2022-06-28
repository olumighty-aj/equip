import 'package:equipro/core/model/ChatListModel.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/base_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class ChatViewModel extends BaseModel {
  final Authentication _authentication = locator<Authentication>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Activities _activities = locator<Activities>();

  Future<List<ChatListModel>> chatList() async {
    //setBusy(true);
    var result = await _activities.chatList();
    if (result is ErrorModel) {
      // showToast('Login failed');
      print(result.error);
      notifyListeners();
      throw Exception('Failed to load internet');
      //return ErrorModel(result.error);
    }
    // print(result);
    return result;
  }

  rate(String id, String comment, double rating) async {
    setBusy(true);
    var result = await _activities.rate(id, comment, rating);

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      _navigationService.pop();
      notifyListeners();
      return SuccessModel(result.data);
    }
  }

  rateOwner(String id, String comment, double rating) async {
    setBusy(true);
    var result = await _activities.rateOwner(id, comment, rating);

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      _navigationService.pop();
      notifyListeners();
      return SuccessModel(result.data);
    }
  }

  updateBooking(String id, String status) async {
    setBusy(true);
    var result = await _activities.updateBooking(id, status);

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      _navigationService.navigateReplacementTo(RentalsRoute);

      notifyListeners();
      return SuccessModel(result.data);
    }
  }
}
