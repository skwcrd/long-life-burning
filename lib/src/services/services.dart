library service;

import 'package:firebase_core/firebase_core.dart'
  show Firebase;

import '../utils/utils.dart'
  show InstanceException;

// import 'authentication/authentication.dart';
import 'database/database.dart';
import 'health/health.dart';
// import 'map/map.dart';
import 'notification/notification.dart';
import 'report/report.dart';

export 'authentication/authentication.dart';
// export 'database/database.dart';
// export 'health/health.dart';
// export 'map/map.dart';
export 'notification/notification.dart';
export 'report/report.dart';

class AppService {
  AppService._() {
    _initialized = true;
  }

  static bool _initialized = false;
  static AppService? _instance;

  /// Singleton instance of AppService.
  static AppService get instance {
    if ( _instance == null ) {
      throw InstanceException(
        className: 'AppService',
        message: 'Please called [AppService.init] before get instance this class');
    }

    return _instance!;
  }

  static Future<AppService> init({
    bool debugMode = false,
  }) async {
    if ( !_initialized ) {
      /// Wait for Firebase to initialize.
      await Firebase.initializeApp();

      await ReportService.init(
        debugMode: debugMode);
      await DatabaseService.init();
      await HealthService.init();
      await NotifyService.init();

      _instance = AppService._();
    }

    return _instance!;
  }
}