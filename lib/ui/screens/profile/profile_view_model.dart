import 'dart:convert';

import 'package:equipro/core/model/ReviewsModel.dart';
import 'package:equipro/core/model/error_model.dart';
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
    String gender,
    String lat,
    String lng,
    String kyc_name,
    String kyc_document_path,
  ) async {
    setBusy(true);
    var result = await _authentication.editProfile(
      displayPicture,
      address,
      gender,
      lat,
      lng,
      kyc_name,
      kyc_document_path,
    );
    if (result == null) {
      setBusy(false);

      notifyListeners();
      return result;
    }
    setBusy(false);
    _authentication.currentUser.userType == "hirers"
        ? _navigationService.pushAndRemoveUntil(homeRoute)
        : _navigationService.pushAndRemoveUntil(HomeOwnerRoute);
    notifyListeners();
    return result;
  }

  Future<List<ReviewsModel>> getReviews() async {
    //setBusy(true);
    var result = await _authentication.getReviews();
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

  Future<List<ReviewsModel>> getHirerReviews(String id) async {
    //setBusy(true);
    var result = await _authentication.getHirerReviews(id);
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
}
