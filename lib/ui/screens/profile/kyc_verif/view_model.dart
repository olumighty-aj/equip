import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equipro/app/app_setup.router.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app_setup.locator.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../utils/helpers.dart';

class KYCViewModel extends BaseViewModel {
  final Authentication _authentication = locator<Authentication>();
  final _navigationService = locator<NavigationService>();

  TextEditingController uploadController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  void init() async {
    countryController.text = _authentication.currentUser.country ?? "";
    notifyListeners();
  }

  String? selectedMOI;
  bool get isOwner => _authentication.isOwner ?? false;

  bool get kycApproved =>
      _authentication.currentUser.kycApproved! == "approved";

  final imagePicker = ImagePicker();

  File? image;

  void onChangedMOI(val) {
    selectedMOI = val;
    notifyListeners();
  }

  void handleChooseFromGalleryId() async {
    File file = File(await imagePicker
        .pickImage(
          source: ImageSource.gallery,
        )
        .then((pickedFile) => pickedFile!.path));
    uploadController.text = file.path;
    // image = file;
    notifyListeners();
  }

  verifyKYC(context) async {
    Map<String, dynamic> data = {
      "kyc_name": selectedMOI == "International Passport"
          ? "international_passport"
          : selectedMOI == "Voters Card"
              ? "voters_card"
              : selectedMOI == "National ID"
                  ? "national_id_card"
                  : selectedMOI == "Driver License"
                      ? "driver_license"
                      : null,
      "kyc_document_path[]": uploadController.text.isNotEmpty
          ? await MultipartFile.fromFile(uploadController.text)
          : null,
      "country": countryController.text
    };
    FormData formData = FormData.fromMap(data);
    BaseDataModel? res = await runBusyFuture(
        _authentication.newVerifyKyc(formData),
        busyObject: "verify");
    if (res?.status == true) {
      showToast(
          res?.message ??
              "KYC submitted successfully and is currently reviewed",
          context: context);
      _navigationService.clearTillFirstAndShow(Routes.profile);
      print("KyC submitted");
    } else {
      showErrorToast(res?.message ?? "Failed, please try again",
          context: context);
    }
  }

  void becomeOwner(context, val) async {
    BaseDataModel? res = await _authentication.becomeOwner();
    if (res?.status == true) {
      _authentication.setOwnerStatus(true);
      notifyListeners();
      showToast(
          "Success!\nYour request to be an owner is currently being reviewed by the admin",
          context: context);
    } else {
      showErrorToast(res?.message ?? "", context: context);
    }
  }
}
