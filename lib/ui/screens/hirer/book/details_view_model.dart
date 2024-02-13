import 'package:equipro/app/app_setup.router.dart';
import 'package:equipro/core/enums/dialog_type.dart';
import 'package:equipro/core/model/BookModel.dart';
import 'package:equipro/core/model/base_model.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app_setup.locator.dart';

class DetailsViewModel extends BaseViewModel {
  final Authentication authentication = locator<Authentication>();
  final _dialogService = locator<DialogService>();
  final Activities _activities = locator<Activities>();

  book(BookModel bookModel, context) async {
    setBusy(true);
    var result = await runBusyFuture(_activities.book(bookModel.toJson()),
        busyObject: "Book");

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error, context: context);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      notifyListeners();
      return SuccessModel(result.data);
    }
  }

  void newBook(BookModel bookModel, context) async {
    BaseDataModel? result = await runBusyFuture(
        _activities.newBook(bookModel.toJson()),
        busyObject: "Book");
    if (result != null) {
      if (result.status == true) {
        print("Status ${result.status}");
        print("Status ${result.message}");
        showToast(result.message!, context: context);
        _dialogService.showCustomDialog(variant: DialogType.bookingRequest);
        // _navigationService.clearStackAndShow(Routes.home);
      } else {
        showErrorToast(result.message ?? "", context: context);
        if (result.message!.contains("KYC")) {
          locator<NavigationService>().navigateTo(Routes.editProfile);
        }
      }
    }
  }
}

extension AmountFormatting on String {
  String get withCommas {
    final formattedWholeNumber = replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
    return formattedWholeNumber;
  }
}
