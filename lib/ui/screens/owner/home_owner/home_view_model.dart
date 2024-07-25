import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equipro/app/app_setup.logger.dart';
import 'package:equipro/app/app_setup.router.dart';
import 'package:equipro/core/model/NotificationModel.dart';
import 'package:equipro/core/model/ReviewsModel.dart';
import 'package:equipro/core/model/enums.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app_setup.locator.dart';
import '../../../../core/api/api_constants.dart';
import '../../../../core/model/base_model/base_model.dart';
import '../../../../core/model/equipments/equipments.dart';
import '../../../../core/model/reviews/reviews.dart';
import '../../../../core/services/shared_prefs.dart';

class HomeOwnerViewModel extends BaseViewModel {
  final Activities _activities = locator<Activities>();
  final Authentication _authentication = locator<Authentication>();
  final _log = getLogger("OwnerHomeViewModel");
  final _navigationService = locator<NavigationService>();
  ScrollController? controller;

  List<Map<String, dynamic>> bookingDetails = [];

  List<EquipmentModel>? _equipments = [];
  List<EquipmentModel>? get equipments => _equipments;

  LoadingState _loadingState = LoadingState.idle;
  LoadingState get loadingState => _loadingState;
  setLoadingState(LoadingState value) {
    _loadingState = value;
    notifyListeners();
  }

  LoadingState _fetchState = LoadingState.idle;
  LoadingState get fetchState => _fetchState;
  setFetchState(LoadingState value) {
    _fetchState = value;
    notifyListeners();
  }

  int? _count;
  int get orderCount => _count!;

  int _nextPage = 2;
  int get nextPage => _nextPage;

  void setModel(model) {
    _activities.setModel(model);
    notifyListeners();
  }

  List<EquipmentModel> _packageList = [];
  List<EquipmentModel> get packageList => _packageList;

  void getEquipmentBookingDetails(id, context) async {
    BaseDataModel res = await runBusyFuture(
        _activities.getEquipmentBookingRequests(id),
        busyObject: "BookingId");
    if (res.status == true) {
      for (var i in res.payload["content"]) {
        Map<String, dynamic> req = i;
        getLogger("Hi").i(req);
        bookingDetails.add(req);
      }
    } else {
      showErrorToast(res.message ?? "", context: context);
    }
  }

  postEquip(
    List images,
    String equipName,
    String costHire,
    String costHireInterval,
    String availFrom,
    String availTo,
    String quantity,
    String description,
    String latitude,
    String longitude,
    String address,
  ) async {
    setBusy(true);
    var result = await runBusyFuture(
        _activities.postEquip(
          images,
          equipName,
          costHire,
          costHireInterval,
          availFrom,
          availTo,
          quantity,
          description,
          latitude,
          longitude,
          address,
        ),
        busyObject: "Posting");
    if (result == null) {
      setBusy(false);
      notifyListeners();
      return result;
    }
    setBusy(false);

    _navigationService.clearStackAndShow(Routes.homeOwner);
    notifyListeners();
    return result;
  }

  Future<bool?> newPostEquip(
      List images,
      String equipName,
      String costHire,
      String costHireInterval,
      String availFrom,
      String availTo,
      String quantity,
      String description,
      String latitude,
      String longitude,
      String address,
      context) async {
    List newImages = [];
    for (var i in images) {
      newImages.add(await MultipartFile.fromFile(i.path));
    }
    Map<String, dynamic> map = {
      "equip_name": equipName,
      "cost_of_hire": costHire,
      "cost_of_hire_interval": costHireInterval,
      "avail_from": availFrom,
      "avail_to": availTo,
      "quantity": quantity,
      "description": description,
      "equip_image_path[]": newImages,
      "latitude": latitude,
      "longitude": longitude,
      "address": address
    };
    FormData data = FormData.fromMap(map);
    BaseDataModel? res = await runBusyFuture(_activities.newPostEquip(data),
        busyObject: "Posting");
    if (res != null) {
      if (res.status == true) {
        showToast(res.message ?? "", context: context);
        _navigationService.clearStackAndShow(Routes.homeOwner);
        return res.status;
      } else {
        showErrorToast(res.message ?? "", context: context);
        return res.status;
      }
    }
  }

  updateEquip(
      List images,
      String equipName,
      String costHire,
      String costHireInterval,
      String availFrom,
      String availTo,
      String quantity,
      String description,
      String id,
      String latitude,
      String longitude,
      String address,
      context) async {
    setBusy(true);
    var result = await runBusyFuture(
        _activities.updateEquip(
          images,
          equipName,
          costHire,
          costHireInterval,
          availFrom,
          availTo,
          quantity,
          description,
          id,
          latitude,
          longitude,
          address,
        ),
        busyObject: "UpdateMyEquip");
    if (result == null) {
      setBusy(false);
      showErrorToast("Failed, please try again", context: context);
      notifyListeners();
      return result;
    }
    setBusy(false);
    notifyListeners();
    showToast(result["message"], context: context);
    _navigationService.clearStackAndShow(Routes.homeOwner);
    return result;
  }

  void newUpdateMyEquipment(
    List images,
    String equipName,
    String costHire,
    String costHireInterval,
    String availFrom,
    String availTo,
    String quantity,
    String description,
    String id,
    String latitude,
    String longitude,
    String address,
  ) {}

  Future<void> getMyEquipment() async {
    //setBusy(true);
    setFetchState(LoadingState.loading);
    BaseDataModel res = await _activities.newGetMyEquipments();
    if (res.status == true) {
      _packageList = [];
      for (var i in res.payload["content"]) {
        EquipmentModel model = EquipmentModel.fromJson(i);
        _packageList.add(model);
      }
      // _packageList = res.payload["content"];
      _count = _activities.count;
      setFetchState(LoadingState.done);
      notifyListeners();
    } else {
      setLoadingState(LoadingState.error);
    }
    // var result = await _activities.getMyEquipment();
    // if (result is ErrorModel) {
    //   // showToast('Login failed');
    //   print(result.error);
    //   setFetchState(LoadingState.error);
    //   notifyListeners();
    //   throw Exception('Failed to load internet');
    //   //return ErrorModel(result.error);
    // } else {
    //   _packageList = result;
    //   _count = _activities.count;
    //   notifyListeners();
    //   setFetchState(LoadingState.done);
    //   return result;
    // }
  }

  Future<void> getEquipments(context) async {
    BaseDataModel? data = await runBusyFuture(_activities.getPagedEquipments());
    if (data != null) {
      if (data.status == true) {
        for (var i in data.payload["content"]) {
          EquipmentModel model = EquipmentModel.fromJson(i);
          _equipments?.add(model);
          notifyListeners();
        }
      } else {
        showErrorToast(data.message ?? "", context: context);
      }
    }
  }

  Future<void> init(context) async {
    _log.i("Refresh");
    await getMyEquipment().then((value) => controller = new ScrollController()
      ..addListener(() {
        getMyEquipmentMore();
      }));
  }

  Future<void> refresh(context) async {
    await init(context);
  }

  getMyEquipmentMore() async {
    //setBusy(true);
    if (controller!.position.extentAfter < 100 &&
        loadingState != LoadingState.loading) {
      if (packageList.length >= orderCount) {
        // showToast('all order History fetched');
      } else {
        setLoadingState(LoadingState.loading);
        var result = await _activities.getMyEquipment(page: nextPage);
        if (result is ErrorModel) {
          // showToast('Login failed');
          print(result.error);
          notifyListeners();
          setLoadingState(LoadingState.error);
          throw Exception('Failed to load internet');
          //return ErrorModel(result.error);
        }
        // print(result);
        else {
          _packageList.addAll(result);
          _nextPage = _nextPage + 1;
          notifyListeners();
          setLoadingState(LoadingState.done);
        }
      }
    }
  }

  getPageEquipmentMore() async {
    //setBusy(true);
    if (controller!.position.extentAfter < 100 &&
        loadingState != LoadingState.loading) {
      if (packageList.length >= orderCount) {
        // showToast('all order History fetched');
      } else {
        setLoadingState(LoadingState.loading);
        var res = await _activities.getPagedEquipments(page: nextPage);
        if (res!.status = false) {
          // showToast('Login failed');
          print(res.message);
          setLoadingState(LoadingState.error);
          throw Exception('Failed to load internet');
          //return ErrorModel(result.error);
        }
        // print(result);
        else {
          for (var i in res.payload["content"]) {
            EquipmentModel model = EquipmentModel.fromJson(i);
            _equipments?.add(model);
            notifyListeners();
          }
          _nextPage = _nextPage + 1;
          notifyListeners();
          setLoadingState(LoadingState.done);
        }
      }
    }
  }

  deleteEquip(String id, context) async {
    // print('dhdhd');
    setBusy(true);
    var result = await _activities.deleteEquip(id);

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error, context: context);
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      _navigationService.clearStackAndShow(Routes.homeOwner);
      // notifyListeners();
      return SuccessModel(result.data);
    }
  }

  void newDeleteEquip(String id, context) async {
    BaseDataModel? res = await _activities.newDeleteEquip(id);
    if (res != null && res.status == true) {
      // _navigationService.back();
      showToast(res.message ?? "", context: context);
      _navigationService.clearStackAndShow(Routes.homeOwner);
    } else {
      showErrorToast(res?.message ?? "", context: context);
    }
  }

  switchHirer(context) async {
    setBusy(true);
    var result = await _authentication.switchRole("hirers");
    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error, context: context);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      _navigationService.clearStackAndShow(Routes.home);
      notifyListeners();
      return SuccessModel(result.data);
    }
  }

  void newSwitchRole(context) async {
    BaseDataModel? res = await runBusyFuture(
        _authentication.newSwitchRole("hirers"),
        busyObject: "Switch");
    if (res != null) {
      if (res.status == true) {
        _log.i("Switch: ${res.payload}");
        _log.i("User: ${_authentication.currentUser.toJson()}");
        ApiConstants.token = res.payload["token"];
        SharedPrefsClient.saveData("token", res.payload["token"]);
        _authentication.setCurrentUser(res.payload["details"]);
        SharedPrefsClient.saveData(
            "currentUser", jsonEncode(res.payload["details"]));
        notifyListeners();
        // showToast(res.message ?? "", context: context);
        _navigationService.clearStackAndShow(Routes.home);
      } else {
        showErrorToast(res.message ?? "", context: context);
      }
    }
  }

  Future<List<EquipmentModel>> searchMyEquipment(String search) async {
    //setBusy(true);
    var result = await _activities.searchMyEquipment(search);
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

  equipApproval(String id, String status) async {
    setBusy(true);
    var result = await _activities.equipApproval(id, status);

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      if (status == "rejected") {
        _navigationService.back();
      } else {
        _navigationService.replaceWith(RentalsRoute);
      }
      notifyListeners();
      return SuccessModel(result.data);
    }
  }

  void newEquipApproval(
      String id, String status, String pickDate, context) async {
    BaseDataModel? res = await runBusyFuture(
        _activities.newEquipApproval(id, status, pickDate),
        busyObject: "Approval");
    if (res?.status != false) {
      showToast(res?.message ?? "Booking accepted", context: context);
      _navigationService.clearStackAndShow(Routes.homeOwner);
    } else {
      showErrorToast(res?.message ?? "", context: context);
    }
  }

  updateAddress(String address, String lat, String lng) async {
    setBusy(true);
    var result = await _authentication.updateAddress(address, lat, lng);
    if (result == null) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return result;
    }
    setBusy(false);
    // _navigationService.pushAndRemoveUntil(HomeOwnerRoute);
    notifyListeners();
    return result;
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

  // Future<List<NotificationModel>> getNotification() async {
  //   //setBusy(true);
  //   var result = await _activities.getNotification();
  //   if (result is ErrorModel) {
  //     if (kDebugMode) {
  //       print(result.error);
  //     }
  //     notifyListeners();
  //     throw Exception('Failed to load internet');
  //     //return ErrorModel(result.error);
  //   }
  //   //print(result);
  //   return result;
  // }

  Future<List<NotificationModel>> getNewNotification() async {
    List<NotificationModel> notifs = [];
    BaseDataModel res = await _activities.newGetNotification();
    if (res.status == true) {
      for (var i in res.payload["content"]) {
        NotificationModel j = NotificationModel.fromJson(i);
        notifs.add(j);
      }
      return notifs;
    } else {
      return [];
    }
  }
}
