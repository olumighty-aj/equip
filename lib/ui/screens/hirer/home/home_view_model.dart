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
import 'package:equipro/utils/base_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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

  List<EquipmentModel> _packageList = [];
  List<EquipmentModel> get packageList => _packageList;

  void newSwitchRole(context) async {
    BaseDataModel? res = await runBusyFuture(
        _authentication.newSwitchRole("owners"),
        busyObject: "Switch");
    if (res != null) {
      if (res.status == true) {
        _log.i("Switch: ${res.payload}");
        _log.i("User: ${_authentication.currentUser.toJson()}");
        ApiConstants.token = res.payload["token"];
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
      _log.i("Package: ${_packageList[0].toJson()}");
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
