import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/core/model/base_model.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/extensions.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app_setup.locator.dart';
import '../../../../app/app_setup.logger.dart';
import '../../../../app/app_setup.router.dart';
import '../../../../core/enums/dialog_type.dart';

class RentalsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialog = locator<DialogService>();
  final Activities _activities = locator<Activities>();
  final Authentication _authentication = locator<Authentication>();
  final _log = getLogger("RentalsViewModel");

  int? dateDifference;

  bool get isNigerian => _authentication.currentUser.country == "Nigeria";

  List<ActiveRentalsModel>? _allRentals;
  List<ActiveRentalsModel>? get allRentals => _allRentals;
  List<ActiveRentalsModel>? _bookedRentals;
  List<ActiveRentalsModel>? get bookedRentals => _bookedRentals;
  List<ActiveRentalsModel>? _receivedRentals;
  List<ActiveRentalsModel>? get receivedRentals => _receivedRentals;
  List<ActiveRentalsModel>? _returnRentals;
  List<ActiveRentalsModel>? get returnRentals => _returnRentals;

  PaymentType? paymentType;

  Future<void> getAllRentals() async {
    BaseDataModel? model = await runBusyFuture(
        _activities.getActiveRentals("all"),
        busyObject: "all");
    _log.d("All Rentals: ${model?.payload}");
    if (model!.payload!["content"].isNotEmpty) {
      _allRentals = [];
      for (var i in model.payload["content"]) {
        _allRentals!.add(ActiveRentalsModel.fromJson(i));
        notifyListeners();
      }
    } else {
      _allRentals = [];
      notifyListeners();
    }
  }

  Future<void> getBookedRentals() async {
    BaseDataModel? model = await runBusyFuture(
        _activities.getActiveRentals("booked"),
        busyObject: "booked");
    if (model?.status == true) {
      if (model!.payload!["content"].isNotEmpty) {
        _bookedRentals = [];
        for (var i in model.payload["content"]) {
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
      if (model!.payload!["content"].isNotEmpty) {
        _receivedRentals = [];
        for (var i in model.payload["content"]) {
          _receivedRentals!.add(ActiveRentalsModel.fromJson(i));
          notifyListeners();
        }
      } else {
        _receivedRentals = [];
        notifyListeners();
      }
    }
  }

  Future<void> getReturnedRentals() async {
    BaseDataModel? model = await runBusyFuture(
        _activities.getActiveRentals("returned"),
        busyObject: "returned");
    if (model?.status == true) {
      if (model!.payload!["content"].isNotEmpty) {
        _returnRentals = [];
        for (var i in model.payload["content"]) {
          _returnRentals!.add(ActiveRentalsModel.fromJson(i));
          notifyListeners();
        }
      } else {
        _returnRentals = [];
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

  initPayment(String orderId, String amount, paymentType, String currency,
      PaymentType type) async {
    this.paymentType = type;
    notifyListeners();

    BaseDataModel model = await runBusyFuture(_activities.initPayment(orderId),
        busyObject: type == PaymentType.paypal
            ? "PaypalInitPayment"
            : "StripeInitPayment");
    if (model.status == true) {
      createPayment(model, amount, paymentType, currency);
    }
  }

  iHaveReceivedEquipment(String equipOrderId, context) async {
    BaseDataModel? model = await runBusyFuture(
        _activities.updateDeliveryStatus(equipOrderId, "delivered_hirer"),
        busyObject: "pickedOwner");
    _log.d("Received raw: ${model?.toJson()}");
    if (model?.status != false) {
      // showToast("Equipment status updated", context: context);
      // _navigationService.back();
      _log.d("I have received: ${model?.toJson()}");
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
      _log.d("Picked from owner: ${model?.toJson()}");
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
      _log.d("In use: ${model?.toJson()}");
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
        _log.d("Return Equipment: ${model?.toJson()}");
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
      _log.d("Picked from hirer: ${model.toJson()}");
      await returnEquipment(equipOrderId, context);
    } else {
      _log.e(model.toJson());
    }
  }

  void createPayment(
      BaseDataModel model, amount, String paymentType, currency) async {
    Map<String, dynamic>? res = await runBusyFuture(
        _activities.createPayment(model.payload["equip_order_id"],
            model.payload["receipt_ref"], amount, paymentType, currency),
        busyObject: "InitPayment");
    // _log.d(model.payload);

    if (res != null) {
      _navigationService.navigateTo(Routes.paymentWebView,
          arguments: PaymentWebViewArguments(
              url: res["payment_link"] ?? res["approval_url"], amount: amount));
    } else {
      _log.e(model.message);
    }
  }

  void extendBooking(Map<String, dynamic> data, context) async {
    BaseDataModel? model = await runBusyFuture(
        _activities.extendEquipmentBook(data),
        busyObject: "extend");
    if (model?.status == true) {
      _log.d("Extend equipment response: ${model!.payload}");
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

  int getDateDifference(String date) {
    try {
      // Parse the specific date string into a DateTime object
      DateTime specificDate = date.toDate();

      // Current date and time
      DateTime currentDate = DateTime.now();

      // Calculate the difference
      Duration difference = currentDate.difference(specificDate);

      // Extract the number of days
      int differenceInDays = difference.inDays;

      print('Difference in days: $differenceInDays days');
      return differenceInDays;
    } catch (e) {
      print('Error parsing date: $e');
      // Handle the error (return a specific value or rethrow the exception)
      return -1; // or throw e; or any other appropriate handling
    }
  }
}

extension StringToDate on String {
  DateTime toDate() {
    List<String> dateParts = this.split('-');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
    // DateFormat()

    return DateTime(year, month, day);
  }
}

enum PaymentType { stripe, paypal }
