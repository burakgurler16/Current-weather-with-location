import 'package:location/location.dart';

class LocationHelper {
  double latitude = 40.193298;
  double longitude = 29.074202;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    //Location için servis ayakta mı?
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    //konum izni kontrolü
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    //izinler tamam ise
    locationData = await location.getLocation();
    latitude = locationData.latitude ?? 40.193298;
    longitude = locationData.longitude ?? 40.193298;
  }
}
