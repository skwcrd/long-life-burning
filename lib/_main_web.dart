import 'dart:async'
  show runZonedGuarded;

import 'package:flutter/widgets.dart'
  show
    runApp,
    WidgetsFlutterBinding;
import 'package:flutter/foundation.dart'
  show
    FlutterError,
    ErrorDescription,
    FlutterErrorDetails;

import 'src/app.dart';
import 'src/utils/utils.dart'
  show AppText;

void run() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    runApp(const App());
  }, (error, stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: "${AppText.app} Exception",
        context: ErrorDescription(
          "Error on runZonedGuarded in main()")));
  });
}