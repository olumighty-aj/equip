import 'package:equipro/core/model/EquipmentModel.dart';
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

class HomeViewModel extends BaseModel {
  final Authentication _authentication = locator<Authentication>();
  final NavigationService _navigationService = locator<NavigationService>();
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


  switchOwner() async {
    setBusy(true);
    var result = await _activities.switchRole();
    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      if (result.data["details"]["address"] == null) {
        _navigationService.navigateTo(SetupOwnerRoute);
      } else {
        _navigationService.navigateTo(HomeOwnerRoute);
      }
      notifyListeners();
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
  Future<List<EquipmentModel>> getEquipment() async {
    //setBusy(true);
    setFetchState(LoadingState.loading);
    var result = await _activities.getEquipments();
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
      notifyListeners();
      setFetchState(LoadingState.done);
      return result;
    }
  }

  getEquipmentMore() async {
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
}
