import 'package:location/location.dart';
import 'package:stacked/stacked.dart';

class LocationSheetViewModel extends BaseViewModel {
  Location location = Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;

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

  Future<bool> requestPermission() async{
    _permissionGranted = await location.requestPermission();
    if(_permissionGranted == PermissionStatus.denied || _permissionGranted == PermissionStatus.deniedForever){
      _permissionGranted = await location.requestPermission();
      if(_permissionGranted== PermissionStatus.denied || _permissionGranted == PermissionStatus.deniedForever){
        return false;
      }
    }
    return _permissionGranted==PermissionStatus.granted||_permissionGranted == PermissionStatus.grantedLimited;
  }
}
