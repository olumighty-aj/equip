import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:equipro/app/app_setup.logger.dart';
import 'package:equipro/core/model/ReviewsModel.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/reviews/reviews.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/extensions.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../app/app_setup.router.dart';
import '../../../core/model/base_model/base_model.dart';

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
  Map<String, dynamic>? postCodeDetail;

  Map<String, dynamic>? verificationDetails;

  TextEditingController nameController = TextEditingController();
  TextEditingController uploadController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();

  String? get hirersPath => _authentication.currentUser.hirersPath;

  bool get kycApproved =>
      _authentication.currentUser.kycApproved! == "approved";
  bool get kycPendng => _authentication.currentUser.kycApproved! == "pending";
  bool get kycUpdated => _authentication.currentUser.kycUpdated!;
  bool get isOwner => _authentication.isOwner ?? false;

  void initProfile() {
    verifyKYC();
    // checkPostCode();
    // ownerCheck(context);
  }

  bool get isNigerian => _authentication.currentUser.country == "Nigeria";

  void checkPostCode() async {
    if (stateController.text.isEmpty && postCodeController.text.isNotEmpty) {
      postCodeDetail =
          await _authentication.fetchPostDetails(postCodeController.text);
      if (postCodeDetail?["status"] == 200) {
        stateController.text = postCodeDetail!["result"]["region"];
        // longitude = postCodeDetail!["result"]["longitude"];
        // latitude = postCodeDetail!["result"]["latitude"];
        // _log.i("Lng: $longitude, Lat: $latitude");
        notifyListeners();
      }
    }
  }

  void initEditProfile() {
    _log.i(_authentication.currentUser.toJson());
    stateController.text = _authentication.currentUser.localState ??
        _authentication.currentUser.address?.extractState() ??
        "";

    // isOwner = _authentication.currentUser.isOwner == "FALSE" ? false : true;
    countryController.text = _authentication.currentUser.country ??
        _authentication.currentUser.address?.extractCountry() ??
        "";
    nameController.text = _authentication.currentUser.fullname!;
    postCodeController.text = _authentication.currentUser.postalCode ?? "";
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
    checkPostCode();
  }

  void onChangePostCode(String val, context) async {
    if (val.length >= 7) {
      _log.i("About to check code");
      postCodeDetail = await runBusyFuture(
          _authentication.fetchPostDetails(val),
          busyObject: "post");
      if (postCodeDetail?["status"] == 200) {
        countryController.text = postCodeDetail!["result"]["country"];
        notifyListeners();
      } else {
        showErrorToast(postCodeDetail!["error"], context: context);
      }
    }
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
          lat: _authentication.currentUser.longitude,
          lng: _authentication.currentUser.latitude,
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
    var dataMapTwo = {
      "address": addressController.text,
      "gender": selectedGender,
      "hirers_path":
          image != null ? await MultipartFile.fromFile(image!.path) : null,
      "latitude": isNigerian
          ? pickLat
          : _authentication.currentUser.latitude ?? pickLat,
      "local_state": stateController.text,
      "longitude": isNigerian
          ? pickLng
          : _authentication.currentUser.longitude ?? pickLng,
      "become_owner": isOwner ? 1 : 0,
    };
    _log.i("Data map 2: $dataMapTwo");
    data = FormData.fromMap(dataMapTwo);
    var res = await runBusyFuture(_authentication.editNewProfile(data),
        busyObject: "Edit");
    if (res != null) {
      if (res.status == true) {
        _log.i("Profile Update res${res.payload}");
        showToast(res.message ?? "Success", context: context);
        _navigationService.clearStackAndShow(
            _authentication.currentUser.userType == "hirers"
                ? Routes.home
                : Routes.homeOwner);
      } else {
        showErrorToast(res.message ?? "", context: context);
      }
    } else {
      // _log.i("Profile Update res${res}");
      showErrorToast("Profile Update failed! Please try again",
          context: context);
    }
  }

  void verifyKYC() async {
    BaseDataModel res =
        await runBusyFuture(_authentication.getKYC(), busyObject: "verify");
    _log.i(res.toJson());
    if (res.status == true && res.payload["content"].isNotEmpty) {
      verificationDetails = res.payload["content"][0];
      notifyListeners();
      _log.i("Verify KYC: ${res.payload}");
    } else {
      verificationDetails = {};
      _log.i("Verify KYC: ${res.payload}");
    }
  }

  Future<List<Reviews>> getReviews() async {
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

  Future<List<Reviews>> getHirerReviews(String id) async {
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
