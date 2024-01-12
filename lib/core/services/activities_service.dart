import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:equipro/app/app_setup.logger.dart';
import 'package:equipro/core/api/api_constants.dart';
import 'package:equipro/core/api/dio_service.dart';
import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/core/model/ChatListModel.dart';
import 'package:equipro/core/model/ChatMessages.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/core/model/NotificationModel.dart';
import 'package:equipro/core/model/ReviewsModel.dart';
import 'package:equipro/core/model/base_model.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as htp;
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/core/services/index.dart';
import 'package:equipro/utils/http/paths.dart';
import 'package:equipro/utils/router/navigation_service.dart';

import '../../app/app_setup.locator.dart';

class Activities {
  final _log = getLogger("Activities");
  final NavService _navigationService = locator<NavService>();
  final Authentication _authentication = locator<Authentication>();
  final _api = locator<ApiService>();
  int? _count;
  int get count => _count ?? 0;

  EquipmentModel? model;

  void setModel(equipModel) {
    model = equipModel;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<BaseDataModel> initPayment(String orderID) async {
    Response res =
        await _api.postRequest({"equip_order_id": orderID}, Paths.initPayment);
    _log.i("Response Data${res.data}");
    return BaseDataModel.fromJson(res.data);
  }

  Future<BaseDataModel> updateDeliveryStatus(
      String equipOrderId, String deliveryStatus) async {
    Response res = await _api.postRequest(
        {"equip_order_id": equipOrderId, "delivery_status": deliveryStatus},
        Paths.deliveryStatus);
    _log.i("Response ${res.data}");
    return BaseDataModel.fromJson(res.data);
  }

  Future<BaseDataModel?> extendEquipmentBook(data) async {
    try {
      Response res = await _api.postRequest(data, Paths.extendBooking);
      if (res.statusCode == 200) {
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e(e.message);
    }
  }

  Future<Map<String, dynamic>> createPayment(String orderID, String receiptRef,
      String amount, String paymentType, String currency) async {
    Response res = await _api.postRequest({
      "equip_order_id": orderID,
      "receipt_ref": receiptRef,
      "amount": amount,
      "payment_type": paymentType,
      "currency": currency
    }, Paths.createPayment);
    _log.i("Response Data${res.data}");
    return res.data;
  }

  Future<BaseDataModel> giveFeedback(Map<String, dynamic> feedback) async {
    Response res = await _api.postRequest(feedback, Paths.review);
    return BaseDataModel.fromJson(res.data);
  }

  Future<BaseDataModel?> getSettings() async {
    try {
      Response res = await _api.getRequest(null,
          Paths.getSettings + "?owner_id=" + _authentication.currentUser.id!);
      if (res.statusCode == 200) {
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e(e.message);
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
    _log.i("Hi, I am here ");
    var header = {
      'X-APP-KEY': 'IFUKpFVCunCU0fK0tQQqTsX',
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${ApiConstants.token}"
    };
    var file;
    int count = 0;
    dynamic catalogueFile;
    final imageUploadRequest =
        htp.MultipartRequest('POST', Uri.parse(baseUrl + 'owners/equipments'));
    _log.i("Hi, I am here 2");
    imageUploadRequest.headers.addAll(header);
    //  imageUploadRequest.fields['UserType'] = currentUser.userInformation.roleId;

    // Attach the file in the request
    _log.i("Hi, I am here 3");
    for (XFile multipleFile in images) {
      count++;
      print(multipleFile.path);
      catalogueFile = await htp.MultipartFile.fromPath(
          'equip_image_path[]', multipleFile.path);
      //print(catalogueFile);
      imageUploadRequest.files.add(catalogueFile);
    }
    _log.i("Hi, I am here 4");

    if (count == images.length) {
      _log.i("Hi, I am here 5");
      imageUploadRequest.fields['equip_name'] = equipName;
      imageUploadRequest.fields['cost_of_hire'] = costHire;
      imageUploadRequest.fields['cost_of_hire_interval'] = costHireInterval;
      imageUploadRequest.fields['avail_from'] = availFrom;
      imageUploadRequest.fields['avail_to'] = availTo;
      imageUploadRequest.fields['quantity'] = quantity;
      imageUploadRequest.fields['description'] = description;
      imageUploadRequest.fields['latitude'] = latitude;
      imageUploadRequest.fields['longitude'] = longitude;
      imageUploadRequest.fields['address'] = address;
    }
    _log.i("Hi, I am here 6");
    try {
      _log.i("Hi, I am here 7");
      print(imageUploadRequest.files);
      final streamedResponse = await imageUploadRequest.send();
      _log.i("Hi, I am here 8");
      final response = await htp.Response.fromStream(streamedResponse);
      _log.i("Hi, I am here 9");
      final Map<String, dynamic> result = json.decode(response.body);
      _log.i("Response: ${result.toString()}");
      if (result["status"] == false) {
        // showErrorToast(result["message"]);
        print(response.body);
        print(response.statusCode);
        return null;
      }
      print(response.statusCode);
      final Map<String, dynamic> result2 = json.decode(response.body);
      print(result2);

      return result2;
    } catch (e) {
      _log.e("From Code");
      print("from code");
      print(e);
      return null;
    }
  }

  Future<BaseDataModel?> newPostEquip(data) async {
    try {
      _log.i("Here 1");
      Response res = await _api.postRequest(data, 'owners/equipments');
      _log.i("Here 2");
      if (res.statusCode == 200) {
        _log.i("Here 3");
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e(e.message);
      _log.e(e.response);
      return BaseDataModel.fromJson(e.response?.data);
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
  ) async {
    var header = {
      'X-APP-KEY': 'IFUKpFVCunCU0fK0tQQqTsX',
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${ApiConstants.token}"
    };
    var file;
    int count = 0;
    dynamic catalogueFile;
    final imageUploadRequest = htp.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'owners/equipments/$id'));
    imageUploadRequest.headers.addAll(header);
    //  imageUploadRequest.fields['UserType'] = currentUser.userInformation.roleId;

    // Attach the file in the request
    for (XFile multipleFile in images) {
      count++;
      print(multipleFile.path);
      catalogueFile = await htp.MultipartFile.fromPath(
          'equip_image_path[]', multipleFile.path);
      //print(catalogueFile);
      imageUploadRequest.files.add(catalogueFile);
    }

    if (count == images.length) {
      imageUploadRequest.fields['equip_name'] = equipName;
      imageUploadRequest.fields['cost_of_hire'] = costHire;
      imageUploadRequest.fields['cost_of_hire_interval'] = costHireInterval;
      imageUploadRequest.fields['avail_from'] = availFrom;
      imageUploadRequest.fields['avail_to'] = availTo;
      imageUploadRequest.fields['quantity'] = quantity;
      imageUploadRequest.fields['description'] = description;
      imageUploadRequest.fields['latitude'] = latitude;
      imageUploadRequest.fields['longitude'] = longitude;
      imageUploadRequest.fields['address'] = address;
    }

    try {
      print(imageUploadRequest.files);
      final streamedResponse = await imageUploadRequest.send();
      final response = await htp.Response.fromStream(streamedResponse);
      final Map<String, dynamic> result = json.decode(response.body);
      if (result["status"] == false) {
        // showErrorToast(result["message"]);
        print(response.body);
        print(response.statusCode);
        return null;
      }
      print(response.statusCode);
      print(result);

      return result;
    } catch (e) {
      print("from code");
      print(e);
      return null;
    }
  }

  // Future<BaseDataModel?> newUpdateMyEquipments(
  //     List images,
  //     String equipName,
  //     String costHire,
  //     String costHireInterval,
  //     String availFrom,
  //     String availTo,
  //     String quantity,
  //     String description,
  //     String id,
  //     String latitude,
  //     String longitude,
  //     String address,
  //     ){
  //
  // }

  Future<BaseDataModel> newGetMyEquipments() async {
    Response res = await _api.getRequest(null, Paths.ownerEquipment);
    return BaseDataModel.fromJson(res.data);
  }

  getMyEquipment({int page = 1}) async {
    try {
      var url = Paths.ownerEquipment;
      // + "?start=0&len=10&paging=$page";
      final result = await http.get(
        url,
      );
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
        var data = result.error;
        List<EquipmentModel> packageList = List<EquipmentModel>.from(
            data.map((item) => EquipmentModel.fromJson(item)));
        return ErrorModel(packageList);
      }
      var data = result.data["payload"]['content'];
      _count = int.parse(result.data["payload"]["totalLength"]);
      _log.i(result.data["payload"]);
      List<EquipmentModel> packageList = List<EquipmentModel>.from(
          data.map((item) => EquipmentModel.fromJson(item)));
      print(packageList);
      return packageList;
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  Future<BaseDataModel> getEquipmentBookingRequests(String id) async {
    try {
      Response res =
          await _api.getRequest(null, Paths.equipmentBookingRequestById + id);
      return BaseDataModel.fromJson(res.data);
    } on DioException catch (e) {
      _log.e(e.message);
      _log.e(e.response);
      return BaseDataModel.fromJson(e.response?.data);
    }
  }

  Future<BaseDataModel?> getPagedEquipments({int page = 1}) async {
    var path = Paths.ownerEquipment + "?start=0&len=10&paging=$page";
    try {
      var res = await _api.getRequest(null, path);
      if (res.statusCode == 200) {
        _log.i(res.data);
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e(e.message);
      _log.e(e.response);
      return BaseDataModel.fromJson(e.response?.data);
    }
  }

  searchMyEquipment(String search) async {
    try {
      var url = Paths.searchMyEquipment + search;
      final result = await http.get(
        url,
      );
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
        var data = result.error;
        List<EquipmentModel> packageList = List<EquipmentModel>.from(
            data.map((item) => EquipmentModel.fromJson(item)));
        return ErrorModel(packageList);
      }
      var data = result.data["payload"]['content'];
      List<EquipmentModel> packageList = List<EquipmentModel>.from(
          data.map((item) => EquipmentModel.fromJson(item)));
      print(packageList);
      return packageList;
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  searchEquipments(String search) async {
    try {
      var url = Paths.searchEquipments + search;
      final result = await http.get(
        url,
      );
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
        var data = result.error;
        List<EquipmentModel> packageList = List<EquipmentModel>.from(
            data.map((item) => EquipmentModel.fromJson(item)));
        return ErrorModel(packageList);
      }
      var data = result.data["payload"]['content'];
      _count = int.parse(result.data["payload"]["totalLength"]);
      List<EquipmentModel> packageList = List<EquipmentModel>.from(
          data.map((item) => EquipmentModel.fromJson(item)));
      print(packageList);
      return packageList;
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  Future<BaseDataModel?> newGetEquipments(String? lat, String? lng) async {
    try {
      Response res =
          await _api.getRequest(null, Paths.equipments + "?lat=$lat&lng=$lng");
      _log.i("Response: ${res.data}");
      if (res.statusCode == 200) {
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e(e.message);
      _log.e(e.response);
      return BaseDataModel.fromJson(e.response?.data);
    }
  }

  getEquipments({int page = 1, String? lat, String? lng}) async {
    try {
      //var url = Paths.equipments + "?lat=$lat&lng=$lng";
      // var url = Paths.equipments + "?start=$page&len=5";
      var url = Paths.equipments + "/lat=$lat&lng=$lng";
      // + "?start=0&len=5&paging=$page&lat=$lat&lng=$lng";
      final result = await http.get(
        url,
      );
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
        var data = result.error;
        List<EquipmentModel> packageList = List<EquipmentModel>.from(
            data.map((item) => EquipmentModel.fromJson(item)));
        return ErrorModel(packageList);
      }
      var data = result.data["payload"]['content'];
      _count = int.parse(result.data["payload"]["totalLength"]);
      List<EquipmentModel> packageList = List<EquipmentModel>.from(
          data.map((item) => EquipmentModel.fromJson(item)));
      print(packageList);
      return packageList;
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  Future<BaseDataModel?> newDeleteEquip(id) async {
    try {
      Response res = await _api.postRequest({}, Paths.deleteEquipment + id);
      if (res.statusCode == 200) {
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e(e.message);
      _log.e(e.response.toString());
      return BaseDataModel.fromJson(e.response?.data);
    }
    // catch(e){
    //
    // }
  }

  deleteEquip(String id) async {
    try {
      var url = Paths.deleteEquipment + id;
      final result = await http.post(url, {});
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
        return ErrorModel(result.error);
      }
      // showToast(result.data['message']);
      return SuccessModel(result.data);
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  Future<BaseDataModel?> newBook(Map<dynamic, dynamic> data) async {
    try {
      Response res = await _api.postRequest(data, Paths.book);
      if (res.statusCode == 200) {
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e(e.message);
      _log.e(e.stackTrace);
      _log.e(e.response);
      return BaseDataModel.fromJson(e.response?.data);
    }
  }

  book(Map<dynamic, dynamic> payload) async {
    try {
      final result = await http.post(Paths.book, payload);
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }

      return SuccessModel(result.data);
    } catch (e) {
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  equipApproval(String id, String status) async {
    try {
      final result =
          await http.post(Paths.equipApproval + id, {"request_status": status});
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }

      return SuccessModel(result.data);
    } catch (e) {
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  Future<BaseDataModel> newEquipApproval(
      String id, String status, String pickDate) async {
    Response res = await _api.postRequest(
        {"request_status": status, "pick_date": pickDate},
        Paths.equipApproval + id);
    return BaseDataModel.fromJson(res.data);
  }

  Future<BaseDataModel> newEditBooking(Map<String, dynamic> data) async {
    Response res = await _api.postRequest(data, Paths.editBookings);
    return BaseDataModel.fromJson(res.data);
  }

  updateBooking(String id, String status) async {
    try {
      final result = await http.post(Paths.updateBookings, {
        "delivery_status": status,
        "equip_order_id": id,
      });
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }

      return SuccessModel(result.data);
    } catch (e) {
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  rate(String id, String comment, double rating) async {
    try {
      final result = await http.post(Paths.rate,
          {"equipments_id": id, "comment": comment, "rating": rating});
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }

      return SuccessModel(result.data);
    } catch (e) {
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  sendDate(
    String date,
    String id,
  ) async {
    try {
      final result = await http.post(Paths.pickDate + id, {"pick_date": date});
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }

      return SuccessModel(result.data);
    } catch (e) {
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  Future<BaseDataModel?> getNewEarnings() async {
    _log.i("Here in Earnings");
    try {
      Response res = await _api.getRequest(null, Paths.ownersEarnings);
      _log.i("Response from Earnings: ${res.data}");
      _log.i("Response from Earnings: ${res.statusCode}");
      if (res.data != null) {
        return BaseDataModel.fromJson(res.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      _log.e(e.message);
      _log.e(e.response?.data);
      _log.e(e.response?.statusMessage);
    }
  }

  withdraw(String amount) async {
    try {
      final result = await http.post(Paths.ownersEarnings, {"amount": amount});
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }

      return SuccessModel(result.data);
    } catch (e) {
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  getEarnings(String amount) async {
    try {
      final result = await http.get(Paths.ownersEarnings);
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }

      return SuccessModel(result.data);
    } catch (e) {
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  rateOwner(String id, String comment, double rating) async {
    try {
      final result = await http.post(Paths.rate_owner,
          {"equipments_id": id, "comment": comment, "rating": rating});
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }

      return SuccessModel(result.data);
    } catch (e) {
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  Future<BaseDataModel?> getActiveRentals(String type) async {
    try {
      Response res = await _api.getRequest(null, Paths.active_rentals + type);
      if (res.statusCode == 200) {
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e("Active Rentals DioException Message: ${e.message}");
    }
  }

  activeRentals(String type) async {
    try {
      final result = await http.get(Paths.active_rentals + type);
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
        var data = result.error;
        List<ActiveRentalsModel> packageList = List<ActiveRentalsModel>.from(
            data.map((item) => ActiveRentalsModel.fromJson(item)));
        return ErrorModel(packageList);
      }
      //print(result.data);
      var data = result.data["payload"]["content"];
      List<ActiveRentalsModel> packageList = List<ActiveRentalsModel>.from(
          data.map((item) => ActiveRentalsModel.fromJson(item)));
      print(packageList);
      return packageList;
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  Future<BaseDataModel?> getChatList() async {
    try {
      var res = await _api.getRequest(null, Paths.chatList);
      if (res.statusCode == 200) {
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e(e.message);
      _log.e(e.response);
      return BaseDataModel.fromJson(e.response?.data);
    }
  }

  chatList() async {
    try {
      final result = await http.get(Paths.chatList);
      if (result is ErrorModel) {
        print("ERROR");
        // print("Result from service: ${result.error}");
        var data = result.error;
        List<ChatListModel> packageList = List<ChatListModel>.from(
            data.map((item) => ChatListModel.fromJson(item)));
        return ErrorModel(packageList);
      }
      //print(result.data);
      var data = result.data["payload"];
      List<ChatListModel> packageList = List<ChatListModel>.from(
          data.map((item) => ChatListModel.fromJson(item)));
      print(packageList);
      return packageList;
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  activeOwnerRentals(String type) async {
    try {
      final result = await http.get(Paths.active_owner_rentals + type);
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
        var data = result.error;
        List<ActiveRentalsModel> packageList = List<ActiveRentalsModel>.from(
            data.map((item) => ActiveRentalsModel.fromJson(item)));
        return ErrorModel(packageList);
      }
      //print(result.data);
      var data = result.data["payload"]["content"];
      List<ActiveRentalsModel> packageList = List<ActiveRentalsModel>.from(
          data.map((item) => ActiveRentalsModel.fromJson(item)));
      print(packageList);
      return packageList;
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  newFetchChatDetails({String? senderId, String? receiverId}) async {
    _log.i("Before Chat Details");
    Response res = await _api.getRequest(
        null, (Paths.chatDetails + "$senderId&receiver=$receiverId"));
    _log.i("Response Chat Details: ${res.data}");
    if (res.statusCode == 200) {
      BaseDataModel data = BaseDataModel.fromJson(res.data);
      if (data.status == true) {
        List<ChatMessages> chats = [];
        for (var i in data.payload) {
          ChatMessages chat = ChatMessages.fromJson(i);
          print(chat.toJson());
          chats.add(chat);
        }
        return chats;
      } else {
        _log.e(data.toJson());
      }
    } else {
      _log.e(res.data);
    }
  }

  fetchChatDetails(String inboxId) async {
    try {
      htp.Response result = await http.getRequest(Paths.chatDetails +
          "${_authentication.currentUser.id}&user_2=$inboxId");
      print("Result from service: ${result.body}");
      Map<String, dynamic> data = jsonDecode(result.body);
      print(data.toString());
      if (data["status"] == false) {
        print("Data: $data");
        // print(result.error);
        // List<ChatMessages> packageList = ChatMessages;
        return data;
      }
      if (data["status"] == true) {
        List<ChatMessages> chats = [];
        for (var i in data["payload"]) {
          ChatMessages chat = ChatMessages.fromJson(i);
          print(chat.toJson());
          chats.add(chat);
        }
        return chats;
      }
      // var data = result.data["payload"];
      // List<ChatMessages> packageList = List<ChatMessages>.from(
      //     data.map((item) => ChatMessages.fromJson(item)));
      // // print(packageList);
      // return packageList;
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  Future<dynamic> fetchChats(String inboxId) async {
    try {
      htp.Response result = await http.get(Paths.chatDetails +
          "${_authentication.currentUser.id}&user_2=$inboxId");
      print("Result from service: ${result.body}");
      if (result is ErrorModel) {}
    } catch (e) {}
  }

  newSendChat(Map<String, dynamic> payload) async {
    try {
      Response res = await _api.postRequest(payload, Paths.sendChat);
      if (res.statusCode == 200) {
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e(e.message);
      _log.e(e.stackTrace);
      _log.e(e.response);
      // return BaseDataModel.fromJson(e.response?.data);
    }
  }

  sendChat(Map<dynamic, dynamic> payload) async {
    try {
      final result = await http.post(Paths.sendChat, payload);
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
        return ErrorModel(result.error);
      }
      return SuccessModel(result.data);
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  getNotification() async {
    try {
      final result = await http.get(Paths.getNotification);
      _log.i("Result lot: ${result.toJson()}");
      if (result is ErrorModel) {
        _log.i("Error Model");
        // if (kDebugMode) {
        //   print("ERROR");
        // }
        var data = result.error;
        if (kDebugMode) {
          print(result.error);
        }
        List<NotificationModel> packageList = List<NotificationModel>.from(
            data.map((item) => NotificationModel.fromJson(item)));
        return ErrorModel(packageList);
      }
      var data = result.data["payload"]['content'];
      List<NotificationModel> packageList = List<NotificationModel>.from(
          data.map((item) => NotificationModel.fromJson(item)));
      // print(packageList);
      return packageList;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return ErrorModel('$e');
    }
  }

  Future<BaseDataModel> newGetNotification() async {
    Response res = await _api.getRequest(null, Paths.getNotification);
    return BaseDataModel.fromJson(res.data);
  }
}
