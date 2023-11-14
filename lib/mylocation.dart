import 'package:geolocator/geolocator.dart';

class MyLocation {
  late double? lat;
  late double? lon;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);
      lat = position.latitude;
      lon = position.longitude;
      return;
      // return position;
    } catch (e) {
      print(e);
      // return null;
    }
  }
}
