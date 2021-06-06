import 'dart:async'
  show runZonedGuarded;
import 'dart:io'
  show Platform;

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
    kDebugMode,
    FlutterError,
    ErrorDescription,
    FlutterErrorDetails;

import 'src/app.dart';
import 'src/services/services.dart';
import 'src/utils/utils.dart'
  show AppText;

void run() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    if ( Platform.isAndroid || Platform.isIOS ) {
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
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

    await AppService.init(
      debugMode: kDebugMode);

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