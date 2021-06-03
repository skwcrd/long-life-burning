library service.map;

import 'package:geolocator/geolocator.dart';

part 'extention.dart';
part 'location.dart';

class MapService {
  MapService._()
    : _location = _LocationService._();

  static MapService? _instance;

  /// Singleton instance of MapService.
  // ignore: prefer_constructors_over_static_methods
  static MapService get instance =>
      _instance ??= MapService._();

  final _LocationService _location;

  Future<bool> checkLocationService() async {
    // Test if location services are enabled.
    final _serviceEnabled = await _location.checkService();

    if ( !_serviceEnabled ) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error(
        const LocationServiceDisabledException());
    }

    var _permission = await _location.checkPermission();

    if ( _permission.isDenied ) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      _permission = await _location.requestPermission();
    }

    return _permission.isAlways || _permission.isWhileInUse;
  }
}