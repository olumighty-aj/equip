import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:equipro/app/app_setup.logger.dart';
import 'dart:io';

import 'package:equipro/core/model/ReviewsModel.dart';
import 'package:equipro/core/model/base_model.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../app/app_setup.router.dart';

class ProfileViewModel extends BaseViewModel {
  final _log = getLogger("ProfileViewModel");
  final Authentication _authentication = locator<Authentication>();
  final _navigationService = locator<NavigationService>();
  final imagePicker = ImagePicker();

  int? selectedQuantity;
  String? pickupTime = DateTime.now().toString();
  String? selectedGender;
  String? selectedMOI;
  String? pickLat;
  String? pickLng;
  File? image;

  Map<String, dynamic>? verificationDetails;

  TextEditingController nameController = TextEditingController();
  TextEditingController uploadController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  String? get hirersPath => _authentication.currentUser.hirersPath;

  bool get kycApproved => _authentication.currentUser.kycApproved! == "1";

  void init() {
    _log.i(_authentication.currentUser.toJson());
    stateController.text = _authentication.currentUser.localState ?? "";
    countryController.text = _authentication.currentUser.country ?? "";
    nameController.text = _authentication.currentUser.fullname!;
    addressController.text = _authentication.currentUser.address != null
        ? _authentication.currentUser.address!
        : "";
    emailController.text = _authentication.currentUser.email != null
        ? _authentication.currentUser.email!
        : "";
    selectedGender = _authentication.currentUser.gender != null
        ? selectedGender = _authentication.currentUser.gender
        : "";
    phoneController.text = _authentication.currentUser.phoneNumber != null
        ? _authentication.currentUser.phoneNumber!
        : "";
    pickLat = _authentication.currentUser.latitude != null
        ? _authentication.currentUser.latitude!
        : "";

    pickLng = _authentication.currentUser.longitude != null
        ? _authentication.currentUser.longitude!
        : "";
    selectedGender = _authentication.currentUser.gender != ""
        ? _authentication.currentUser.gender == "male"
            ? "Male"
            : "Female"
        : null;
    verifyKYC();
  }

  void showPlacePicker() async {
    LocationResult result = await _navigationService.navigateTo(
        Routes.placePicker,
        arguments: PlacePickerArguments(
            apiKey: "AIzaSyAsoaOKfTVMSJll6LvVcQ3sYgALbwJ0B9A"));

    print(result);
    addressController.text = result.formattedAddress!;
    pickLat = result.latLng!.latitude.toString();
    pickLng = result.latLng!.longitude.toString();
    notifyListeners();
  }

  void onChangedGender(val) {
    selectedGender = val;
    notifyListeners();
  }

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

  handleChooseFromCamera() async {
    File file = File(await imagePicker
        .pickImage(
          source: ImageSource.camera,
        )
        .then((pickedFile) => pickedFile!.path));
    image = file;
    notifyListeners();
  }

  handleChooseFromGallery() async {
    File file = File(await imagePicker
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((pickedFile) {
      print("Picked File: ${pickedFile?.path}");
      return pickedFile!.path;
    }));
    image = file;
    print("Image path: ${image?.path}");
    notifyListeners();
  }

  void editProfile() async {
    setBusy(true);
    // print("Image: ${image?.path}");
    var result = await runBusyFuture(
        _authentication.editProfile(
          displayPicture: image?.path ?? "",
          address: addressController.text,
          gender: selectedGender!,
          lat: pickLat.toString(),
          lng: pickLng.toString(),
          kyc_name: selectedMOI == "International Passport"
              ? "international_passport"
              : selectedMOI == "Voters Card"
                  ? "voters_card"
                  : selectedMOI == "National ID"
                      ? "national_id_card"
                      : selectedMOI == "Driver License"
                          ? "driver_license"
                          : "",
          kyc_document_path: uploadController.text,
        ),
        busyObject: "Edit");
    if (result == null) {
      setBusy(false);

      notifyListeners();
      return result;
    }
    setBusy(false);
    _authentication.currentUser.userType == "hirers"
        ? _navigationService.clearStackAndShow(Routes.home)
        : _navigationService.clearStackAndShow(Routes.homeOwner);
    notifyListeners();
    return result;
  }

  void newEditProfile(context) async {
    _log.i("KYC APPROVED: ${_authentication.currentUser.kycApproved}");
    FormData data;
    if (_authentication.currentUser.kycApproved == false) {
      data = FormData.fromMap({
        "address": addressController.text,
        "gender": selectedGender,
        "local_state": stateController.text,
        "country": countryController.text,
        "hirers_path":
            image != null ? await MultipartFile.fromFile(image!.path) : null,
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
        "latitude": pickLat,
        "longitude": pickLng,
      });
    } else {
      data = FormData.fromMap({
        "address": addressController.text,
        "gender": selectedGender,
        "hirers_path":
            image != null ? await MultipartFile.fromFile(image!.path) : null,
        "latitude": pickLat,
        "longitude": pickLng,
      });
    }
    var res = await runBusyFuture(_authentication.editNewProfile(data),
        busyObject: "Edit");
    if (res != null) {
      if (res.status == true) {
        _log.i(res.payload);
        showToast(res.message ?? "Success", context: context);
        _navigationService.clearStackAndShow(
            _authentication.currentUser.userType == "hirers"
                ? Routes.home
                : Routes.homeOwner);
      } else {
        showErrorToast(res.message ?? "", context: context);
      }
    } else {
      showErrorToast("Profile Update failed! Please try again",
          context: context);
    }
  }

  void verifyKYC() async {
    BaseDataModel res =
        await runBusyFuture(_authentication.getKYC(), busyObject: "verify");
    if (res.status == true && res.payload["content"].isNotEmpty) {
      verificationDetails = res.payload["content"][0];
      notifyListeners();
      _log.i("Verify KYC: ${res.payload}");
    } else {
      verificationDetails = {};
      _log.i("Verify KYC: ${res.payload}");
    }
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
