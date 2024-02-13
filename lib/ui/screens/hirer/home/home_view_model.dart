import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipro/app/app_setup.logger.dart';
import 'package:equipro/app/app_setup.router.dart';
import 'package:equipro/core/api/api_constants.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/core/model/base_model.dart';
import 'package:equipro/core/model/enums.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../core/model/SignInResponse.dart';
import '../../../../core/services/shared_prefs.dart';

class HomeViewModel extends BaseViewModel {
  final _log = getLogger("HomeViewModel");
  final Authentication _authentication = locator<Authentication>();
  final _navigationService = locator<NavigationService>();
  final Activities _activities = locator<Activities>();
  ScrollController? controller;

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

  init(lat, lng, context) async {
    BaseDataModel data = await _authentication.getUserProfile();
    _authentication.updateUser(Details.fromJson(data.payload));
    await ownerCheck(context);
    await newGetEquipments(lat, lng);
    notifyListeners();
  }

  Future<void> ownerCheck(context) async {
    BaseDataModel? res = await _authentication.ownerCheck();
    if (res?.status == true) {
      _log.d("HI I am here Home View owner check");
      _authentication.setOwnerStatus(res?.status as bool);
      // isOwner = res?.status as bool;
      notifyListeners();
    } else {
      _authentication.setOwnerStatus(res?.status as bool);
    }
  }

  Future<void> refresh(lat, lng, context) async {
    await init(lat, lng, context);
  }

  List<EquipmentModel> _packageList = [];
  List<EquipmentModel> _refreshedList = [];
  List<EquipmentModel> get packageList => _packageList;

  void newSwitchRole(context) async {
    BaseDataModel? res = await runBusyFuture(
        _authentication.newSwitchRole("owners"),
        busyObject: "Switch");
    if (res != null) {
      if (res.status == true) {
        _log.d("Switch: ${res.payload}");
        _log.d("User: ${_authentication.currentUser.toJson()}");
        _authentication.setCurrentUser(res.payload["details"]);
        SharedPrefsClient.saveData(
            "currentUser", jsonEncode(res.payload["details"]));
        ApiConstants.token = res.payload["token"];
        SharedPrefsClient.saveData("token", res.payload["token"]);
        _log.d("User: ${_authentication.currentUser.toJson()}");
        notifyListeners();
        // showToast(res.message ?? "", context: context);
        _navigationService.clearStackAndShow(Routes.homeOwner);
      } else {
        showErrorToast(res.message ?? "", context: context);
      }
    }
  }

  switchOwner(context) async {
    setBusy(true);
    var result = await _authentication.switchRole("owners");
    if (result is ErrorModel) {
      print("Not Successful");
      setBusy(false);
      // showErrorToast(result.error, context: context);
      // notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      print("IsSuccessful");
      setBusy(false);
      showToast(result.data, context: context);
      // if (result.data["details"]["address"] == null) {
      //   _navigationService.pushAndRemoveUntil(SetupOwnerRoute);
      // } else {
      _navigationService.clearStackAndShow(Routes.homeOwner);
      // }
      // notifyListeners();
      return SuccessModel(result.data);
    }
  }

  Future<List<EquipmentModel>> searchEquipments(String search) async {
    //setBusy(true);
    var result = await _activities.searchEquipments(search);
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

  Future<List<EquipmentModel>> newGetEquipments(
      String? lat, String? lng) async {
    setFetchState(LoadingState.loading);
    notifyListeners();
    BaseDataModel? res = await _activities.newGetEquipments(lat, lng);
    if (res!.status == true) {
      _refreshedList.clear();
      for (var i in res.payload["content"]) {
        EquipmentModel equip = EquipmentModel.fromJson(i);
        _refreshedList.add(equip);
        notifyListeners();
      }
      _packageList = _refreshedList;
      _count = _activities.count;
      notifyListeners();
      setFetchState(LoadingState.done);
      // _log.d("Package: ${_packageList[0].toJson()}");
    }
    return _packageList;
  }

  Future<List<EquipmentModel>> getEquipment(String? lat, String? lng) async {
    //setBusy(true);
    print("lat and lng sent");
    print(lat);
    print(lng);
    setFetchState(LoadingState.loading);
    var result = await _activities.getEquipments(lat: lat, lng: lng);
    if (result is ErrorModel) {
      // showToast('Login failed');
      print(result.error);
      setFetchState(LoadingState.error);
      notifyListeners();
      throw Exception('Failed to load internet');
      //return ErrorModel(result.error);
    } else {
      _packageList = result;
      _count = _activities.count;
      _log.d("Package: ${_packageList[0].toJson()}");
      notifyListeners();
      setFetchState(LoadingState.done);
      return result;
    }
  }

  getEquipmentMore(String? lat, String? lng) async {
    //setBusy(true);
    if (controller!.position.extentAfter < 100 &&
        loadingState != LoadingState.loading) {
      if (packageList.length >= orderCount) {
        // showToast('all order History fetched');
      } else {
        setLoadingState(LoadingState.loading);
        var result =
            await _activities.getEquipments(page: nextPage, lat: lat, lng: lng);
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
}
