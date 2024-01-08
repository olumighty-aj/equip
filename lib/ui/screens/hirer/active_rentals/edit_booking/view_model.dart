import 'package:equipro/core/model/base_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/app_setup.locator.dart';
import '../../../../../core/services/activities_service.dart';

class EditBookingViewModel extends BaseViewModel {
  final _activities = locator<Activities>();
  final _nav = locator<NavigationService>();
  // int? selectedQuantity;
  // var quantityList;
  // String? pickupTime = DateTime.now().toString();
  // String? selectedDate;
  // String? selectedWeek;
  // String? selectedDateTo;
  // double? pickLat;
  // double? pickLng;
  // TextEditingController deliveryController = TextEditingController();

  init() {}

  void submitEditBooking(data, context) async {
    BaseDataModel res = await runBusyFuture(_activities.newEditBooking(data),
        busyObject: "Editing");
    if (res.status == true) {
      showToast(res.message ?? "", context: context);
      _nav.back();
    } else {
      showErrorToast(res.message ?? "", context: context);
    }
  }
}
