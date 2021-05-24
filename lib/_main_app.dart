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

import 'package:firebase_core/firebase_core.dart'
  show Firebase;

import 'src/app.dart';
import 'src/utils/utils.dart'
  show AppText;

void run() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
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

    /// Wait for Firebase to initialize.
    await Firebase.initializeApp();

    runApp(const MobileApp());
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