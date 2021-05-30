part of service.map;

class _LocationService {
  _LocationService._();

  Future<bool> checkService() async {
    // Test if location services are enabled.
    final _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if ( !_serviceEnabled ) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return _serviceEnabled;
  }

  Future<LocationPermission> checkPermission() async {
    final _permission = await Geolocator.checkPermission();

    if ( _permission.isDeniedForever ) {
      // Permissions are denied forever, handle appropriately.
      throw const PermissionDeniedException(
        "Location permissions are permanently denied, "
        "we cannot request permissions.");
      // return Future.error(
      //   "Location permissions are permanently denied, "
      //   "we cannot request permissions.");
    }

    return _permission;
  }

  Future<LocationPermission> requestPermission() async {
    final _permission = await Geolocator.requestPermission();

    if ( _permission.isDenied ) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      throw const PermissionDeniedException(
        'Location permissions are denied');
      // return Future.error(
      //   'Location permissions are denied');
    }

    return _permission;
  }
}