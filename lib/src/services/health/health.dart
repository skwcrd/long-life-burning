library service.health;

// import 'package:health/health.dart';
// import 'package:pedometer/pedometer.dart';

import '../../utils/utils.dart'
  show InstanceException;

class HealthService {
  HealthService._();

  static HealthService? _instance;

  /// Singleton instance of HealthService.
  // ignore: prefer_constructors_over_static_methods
  static HealthService get instance {
    if ( _instance == null ) {
      throw InstanceException(
        className: 'HealthService',
        message: 'Please called [HealthService.init] before get instance this class');
    }

    return _instance!;
  }

  static Future<HealthService> init() async =>
      _instance ??= HealthService._();
}