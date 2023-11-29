import 'package:location/location.dart';
import 'package:stacked/stacked.dart';

class LocationService with ListenableServiceMixin {
  final Location _location = Location();

  bool _isLocationOn = false;
  bool get isLocationOn => _isLocationOn;

  @override
  // List<ListenableServiceMixin> get listenableServices => [_location];

  Future<void> checkLocationStatus() async {
    _isLocationOn = await _location.serviceEnabled();
    notifyListeners();
  }

  Future<void> openLocationSettings() async {
    await _location.requestService();
  }

// You can add more methods related to location handling here
}
