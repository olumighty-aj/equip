import 'package:equipro/app/app_setup.logger.dart';
import 'package:equipro/core/model/ChatListModel.dart';
import 'package:equipro/core/model/base_model.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  final NavService _navigationService = locator<NavService>();
  final Activities _activities = locator<Activities>();

  List<ChatListModel>? _chatList = [];
  List<ChatListModel>? get chats =>
      _chatList?.where((element) => element.chatWith != null).toList();

  String? emptyChatText;

  Future<List<ChatListModel>> chatList() async {
    //setBusy(true);
    var result = await _activities.chatList();
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

  Future<void> getChats() async {
    BaseDataModel? data =
        await runBusyFuture(_activities.getChatList(), busyObject: "Chats");
    if (data != null) {
      if (data.status == true) {
        getLogger("ChatViewModel").i(data.toJson());
        for (var i in data.payload) {
          ChatListModel model = ChatListModel.fromJson(i);
          _chatList?.add(model);
          notifyListeners();
        }
      } else {
        emptyChatText = data.message;
        notifyListeners();
      }
    }
  }

  void init() {
    getChats();
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
      _navigationService.pop();
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
      _navigationService.pop();
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
      _navigationService.navigateReplacementTo(RentalsRoute);

      notifyListeners();
      return SuccessModel(result.data);
    }
  }
}
