import 'dart:async'
  show runZonedGuarded;

import 'package:flutter/material.dart'
  show Colors;
import 'package:flutter/services.dart'
  show
    SystemChrome,
    DeviceOrientation,
    SystemUiOverlayStyle;
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

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    /// mobile setup [SystemChrome] application
    /// orientation to portrait only.
    ///
    /// and set [OverlayStyle] for status bar
    /// on mobile, when used application.
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    runApp(const App());
  }, (error, stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace ?? StackTrace.current,
        library: "${AppText.app} Exception",
        context: ErrorDescription(
          "Error on runZonedGuarded in main()")));
  });
}