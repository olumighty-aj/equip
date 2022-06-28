import 'dart:convert';
import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/core/model/ChatListModel.dart';
import 'package:equipro/core/model/ChatMessages.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/core/model/ReviewsModel.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as htp;
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/core/services/index.dart';
import 'package:equipro/utils/http/paths.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';

class Activities {
  final NavigationService _navigationService = locator<NavigationService>();
  final Authentication _authentication = locator<Authentication>();
  int? _count;
  int get count => _count!;

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
    var header = {
      'X-APP-KEY': '37T8O89O445568u89WELrVl',
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${_authentication.token.token}"
    };
    var file;
    int count = 0;
    dynamic catalogueFile;
    final imageUploadRequest =
        htp.MultipartRequest('POST', Uri.parse(baseUrl + 'owners/equipments'));
    imageUploadRequest.headers.addAll(header);
    //  imageUploadRequest.fields['UserType'] = currentUser.userInformation.roleId;

    // Attach the file in the request
    for (XFile multipleFile in images) {
      count++;
      print(multipleFile.path);
      catalogueFile = await htp.MultipartFile.fromPath(
          'equip_image_path', multipleFile.path);
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
        print(response.body);
        print(response.statusCode);
        return null;
      }
      print(response.statusCode);
      final Map<String, dynamic> result2 = json.decode(response.body);
      print(result2);

      return result2;
    } catch (e) {
      print("from code");
      print(e);
      return null;
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
      'X-APP-KEY': '37T8O89O445568u89WELrVl',
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${_authentication.token.token}"
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
          'equip_image_path', multipleFile.path);
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
      if (response.statusCode != 200) {
        print(response.body);
        print(response.statusCode);
        return null;
      }
      print(response.statusCode);
      final Map<String, dynamic> result = json.decode(response.body);
      print(result);

      return result;
    } catch (e) {
      print("from code");
      print(e);
      return null;
    }
  }

  getMyEquipment({int page = 1}) async {
    try {
      var url = Paths.ownerEquipment + "?start=0&len=10&paging=$page";
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

  getEquipments({int page = 1, String? lat, String? lng}) async {
    try {
      //var url = Paths.equipments + "?lat=$lat&lng=$lng";
      // var url = Paths.equipments + "?start=$page&len=5";
      var url =
          Paths.equipments + "?start=0&len=5&paging=$page&lat=$lat&lng=$lng";
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

  deleteEquip(String id) async {
    try {
      var url = Paths.deleteEquipment + id;
      final result = await http.post(url, {});
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
        return ErrorModel(result.error);
      }
      showToast(result.data['message']);
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
      final result = await http
          .post(Paths.equipApproval + id, {"request_status": status});
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

  updateBooking(String id, String status) async {
    try {
      final result = await http
          .post(Paths.updateBookings, {

            "delivery_status": id,
        "equipments_id": status,

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


  sendDate(String date,String id, ) async {
    try {
      final result = await http.post(Paths.pickDate +id,
          {"pick_date": date});
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

  chatList() async {
    try {
      final result = await http.get(Paths.chatList);
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
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

  fetchChat(String inboxId) async {
    try {
      final result = await http.get(
          Paths.chatDetails + inboxId);
      if (result is ErrorModel) {
        print("ERROR");
        var data = result.error;
        // print(result.error);
        List<ChatMessages> packageList = List<ChatMessages>.from(
            data.map((item) => ChatMessages.fromJson(item)));
        return ErrorModel(packageList);
      }
      var data = result.data["payload"];
      List<ChatMessages> packageList = List<ChatMessages>.from(
          data.map((item) => ChatMessages.fromJson(item)));
      // print(packageList);
      return packageList;
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() =="SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"?"Your internet is not stable kindly reconnect and try again":e.toString() == "TimeoutException after 0:00:40.000000: Future not completed"?"Your internet is not stable kindly reconnect and try again":e.toString());
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
      return ErrorModel(e.toString() =="SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"?"Your internet is not stable kindly reconnect and try again":e.toString() == "TimeoutException after 0:00:40.000000: Future not completed"?"Your internet is not stable kindly reconnect and try again":e.toString());
    }
  }
}
