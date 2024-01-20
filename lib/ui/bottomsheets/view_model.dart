import 'package:location/location.dart';
import 'package:stacked/stacked.dart';

class LocationSheetViewModel extends BaseViewModel {
  Location location = Location();

  bool? _serviceEnabled;

  Future<bool> requestLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return false;
      }
    }
    return _serviceEnabled!;
  }
}
