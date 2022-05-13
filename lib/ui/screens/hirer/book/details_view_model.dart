import 'package:equipro/core/model/BookModel.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/base_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class DetailsViewModel extends BaseModel {
  final Authentication _authentication = locator<Authentication>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Activities _activities = locator<Activities>();

  book(BookModel bookModel) async {
    setBusy(true);
    var result = await _activities.book(bookModel.toJson());

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      notifyListeners();
      return SuccessModel(result.data);
    }
  }


}
