import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/core/model/base_model.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app_setup.locator.dart';
import '../../../../app/app_setup.logger.dart';
import '../../../../app/app_setup.router.dart';
import '../../../../core/enums/dialog_type.dart';

class RentalsViewModel extends BaseViewModel {
  final Authentication _authentication = locator<Authentication>();
  final _navigationService = locator<NavigationService>();
  final _dialog = locator<DialogService>();
  final Activities _activities = locator<Activities>();
  final _log = getLogger("RentalsViewModel");

  List<ActiveRentalsModel>? _allRentals;
  List<ActiveRentalsModel>? get allRentals => _allRentals;
  List<ActiveRentalsModel>? _bookedRentals;
  List<ActiveRentalsModel>? get bookedRentals => _bookedRentals;
  List<ActiveRentalsModel>? _receivedRentals;
  List<ActiveRentalsModel>? get receivedRentals => _receivedRentals;
  List<ActiveRentalsModel>? _returnRentals;
  List<ActiveRentalsModel>? get returnRentals => _returnRentals;

  Future<void> getAllRentals() async {
    BaseDataModel? model = await runBusyFuture(
        _activities.getActiveRentals("all"),
        busyObject: "all");
    if (model?.status == true) {
      for (var i in model!.payload["content"]) {
        _allRentals = [];

        _allRentals!.add(ActiveRentalsModel.fromJson(i));
        notifyListeners();
      }
    }
  }

  Future<void> getBookedRentals() async {
    BaseDataModel? model = await runBusyFuture(
        _activities.getActiveRentals("booked"),
        busyObject: "booked");
    if (model?.status == true) {
      if (model!.payload!["content"].isNotEmpty) {
        for (var i in model.payload["content"]) {
          _bookedRentals = [];
          _bookedRentals!.add(ActiveRentalsModel.fromJson(i));
          notifyListeners();
        }
      } else {
        _bookedRentals = [];
        notifyListeners();
      }
    }
  }

  Future<void> getReceivedRentals() async {
    BaseDataModel? model = await runBusyFuture(
        _activities.getActiveRentals("received"),
        busyObject: "received");
    if (model?.status == true) {
      for (var i in model!.payload["content"]) {
        _receivedRentals = [];
        _receivedRentals!.add(ActiveRentalsModel.fromJson(i));
        notifyListeners();
      }
    }
  }

  Future<void> getReturnedRentals() async {
    BaseDataModel? model = await runBusyFuture(
        _activities.getActiveRentals("returned"),
        busyObject: "returned");
    if (model?.status == true) {
      for (var i in model!.payload["content"]) {
        _returnRentals = [];
        _returnRentals!.add(ActiveRentalsModel.fromJson(i));
        notifyListeners();
      }
    }
  }

  void getRentals() async {
    await getAllRentals();
    getBookedRentals();
    getReceivedRentals();
    getReturnedRentals();
  }

  Future<void> refreshRentals() async {
    await getAllRentals();
    getBookedRentals();
    getReceivedRentals();
    getReturnedRentals();
  }

  Future<void> getNewActiveRentals(int type) async {
    //setBusy(true);
    var result = await runBusyFuture(
        _activities.activeRentals(getRentalType(type)),
        busyObject: "rentals");
    if (result is ErrorModel) {
      // showToast('Login failed');
      print(result.error);
      notifyListeners();
      throw Exception('Failed to load internet');
      //return ErrorModel(result.error);
    }
    if (type == 0) {
      _allRentals = result;
      notifyListeners();
    } else if (type == 1) {
      _bookedRentals = result;
      notifyListeners();
    } else if (type == 2) {
      _receivedRentals = result;
      notifyListeners();
    } else {
      _returnRentals = result;
      notifyListeners();
    }
    // print(result);
    // return result;
  }

  // void updateList(List<ActiveRentalsModel> list, index){
  //   if()
  //
  // }

  Future<List<ActiveRentalsModel>> activeRentals(String type) async {
    //setBusy(true);
    var result = await _activities.activeRentals(type);
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

  String getRentalType(int index) {
    switch (index) {
      case 0:
        return "all";
      case 1:
        return "booked";
      case 2:
        return "received";
      case 3:
        return "returned";
      default:
        return "all";
    }
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
      _navigationService.back();
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
      _navigationService.back();
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
      _navigationService.replaceWith(Routes.rentals);

      notifyListeners();
      return SuccessModel(result.data);
    }
  }

  initPayment(
      String orderId, String amount, paymentType, String currency) async {
    BaseDataModel model = await runBusyFuture(_activities.initPayment(orderId),
        busyObject: "InitPayment");
    if (model.status == true) {
      createPayment(model, amount, paymentType, currency);
    }
  }

  iHaveReceivedEquipment(String equipOrderId, context) async {
    BaseDataModel? model = await runBusyFuture(
        _activities.updateDeliveryStatus(equipOrderId, "delivered_hirer"),
        busyObject: "pickedOwner");
    _log.i("Received raw: ${model?.toJson()}");
    if (model?.status != false) {
      // showToast("Equipment status updated", context: context);
      // _navigationService.back();
      _log.i("I have received: ${model?.toJson()}");
      await inUse(equipOrderId, context);
    } else {
      showErrorToast(model?.message ?? "", context: context);
      _log.e(model?.toJson());
    }
  }

  void pickedUpFromOwner(String equipOrderId, context) async {
    BaseDataModel? model = await runBusyFuture(
        _activities.updateDeliveryStatus(equipOrderId, "picked_from_owner"),
        busyObject: "pickedOwner");
    if (model?.status != false) {
      _log.i("Picked from owner: ${model?.toJson()}");
      await iHaveReceivedEquipment(equipOrderId, context);
    } else {
      _log.e(model?.toJson());
    }
  }

  inUse(String equipOrderId, context) async {
    BaseDataModel? model = await runBusyFuture(
        _activities.updateDeliveryStatus(equipOrderId, "in_use"),
        busyObject: "pickedOwner");
    if (model?.status != false) {
      _log.i("In use: ${model?.toJson()}");
      showToast("Equipment status updated", context: context);
      _navigationService.clearTillFirstAndShow(Routes.rentals);
    } else {
      showErrorToast(model?.message ?? "", context: context);
      _log.e(model?.toJson());
    }
  }

  returnEquipment(String equipOrderId, context) async {
    DialogResponse? res =
        await _dialog.showCustomDialog(variant: DialogType.returnEquip);
    if (res?.data == "confirm") {
      BaseDataModel? model = await runBusyFuture(
          _activities.updateDeliveryStatus(equipOrderId, "returned"),
          busyObject: "returned");
      if (model?.status != false) {
        _log.i("Return Equipment: ${model?.toJson()}");
        showToast("Equipment status updated", context: context);
        _navigationService.back();
      } else {
        showErrorToast(model?.message ?? "", context: context);
        _log.e(model?.toJson());
      }
    } else {}
  }

  void pickedFromHirer(String equipOrderId, context) async {
    BaseDataModel model = await runBusyFuture(
        _activities.updateDeliveryStatus(equipOrderId, "picked_from_hirer"),
        busyObject: "returned");
    if (model.status == true) {
      _log.i("Picked from hirer: ${model.toJson()}");
      await returnEquipment(equipOrderId, context);
    } else {
      _log.e(model.toJson());
    }
  }

  void createPayment(BaseDataModel model, amount, paymentType, currency) async {
    Map<String, dynamic>? res = await runBusyFuture(
        _activities.createPayment(model.payload["equip_order_id"],
            model.payload["receipt_ref"], amount, paymentType, currency),
        busyObject: "InitPayment");
    // _log.i(model.payload);

    if (res != null) {
      _navigationService.navigateTo(Routes.paymentWebView,
          arguments: PaymentWebViewArguments(
              url: res["payment_link"], amount: amount));
    } else {
      _log.e(model.message);
    }
  }

  void extendBooking(data, context) async {
    BaseDataModel? model = await runBusyFuture(
        _activities.extendEquipmentBook(data),
        busyObject: "extend");
    if (model?.status == true) {
      _log.i("Extend equipment response: ${model!.payload}");
      _dialog.showCustomDialog(variant: DialogType.bookingRequest);
      // showToast(model.message ?? "", context: context);
      _navigationService.clearTillFirstAndShow(Routes.rentals);
    } else {
      showErrorToast(model?.message ?? "Failed, please try again",
          context: context);
    }
  }

  void giveFeedback(
      String equipId, String comment, double rating, context) async {
    BaseDataModel res = await runBusyFuture(
        _activities.giveFeedback(
            {"equipments_id": equipId, "comment": comment, "rating": rating}),
        busyObject: "feedback");
    if (res.status == true) {
      showToast("Successfully submitted review", context: context);
      _navigationService.clearTillFirstAndShow(Routes.rentals);
    }
  }
}
