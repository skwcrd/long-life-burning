import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Inspect Google Maps state using the platform SDK.
///
/// This class is primarily used for testing. The methods on this
/// class should call "getters" on the GoogleMap object or equivalent
/// on the platform side.
class MapInspector {
  MapInspector(this._channel);

  final MethodChannel _channel;

  Future<bool> isCompassEnabled() =>
      _channel.invokeMethod<bool>('map#isCompassEnabled');

  Future<bool> isMapToolbarEnabled() =>
      _channel.invokeMethod<bool>('map#isMapToolbarEnabled');

  Future<MinMaxZoomPreference> getMinMaxZoomLevels() async {
    final List<double> zoomLevels =
        (await _channel.invokeMethod<List<dynamic>>('map#getMinMaxZoomLevels'))
            .cast<double>();

    return MinMaxZoomPreference(zoomLevels[0], zoomLevels[1]);
  }

  Future<double> getZoomLevel() =>
      _channel.invokeMethod<double>('map#getZoomLevel');

  Future<bool> isZoomGesturesEnabled() =>
      _channel.invokeMethod<bool>('map#isZoomGesturesEnabled');

  Future<bool> isZoomControlsEnabled() =>
      _channel.invokeMethod<bool>('map#isZoomControlsEnabled');

  Future<bool> isLiteModeEnabled() =>
      _channel.invokeMethod<bool>('map#isLiteModeEnabled');

  Future<bool> isRotateGesturesEnabled() =>
      _channel.invokeMethod<bool>('map#isRotateGesturesEnabled');

  Future<bool> isTiltGesturesEnabled() =>
      _channel.invokeMethod<bool>('map#isTiltGesturesEnabled');

  Future<bool> isScrollGesturesEnabled() =>
      _channel.invokeMethod<bool>('map#isScrollGesturesEnabled');

  Future<bool> isMyLocationButtonEnabled() =>
      _channel.invokeMethod<bool>('map#isMyLocationButtonEnabled');

  Future<bool> isTrafficEnabled() =>
      _channel.invokeMethod<bool>('map#isTrafficEnabled');

  Future<bool> isBuildingsEnabled() =>
      _channel.invokeMethod<bool>('map#isBuildingsEnabled');

  Future<Uint8List> takeSnapshot() =>
      _channel.invokeMethod<Uint8List>('map#takeSnapshot');

  Future<Map<String, dynamic>> getTileOverlayInfo(String id) =>
      _channel.invokeMapMethod<String, dynamic>(
        'map#getTileOverlayInfo',
        <String, String>{
          'tileOverlayId': id,
        });
}