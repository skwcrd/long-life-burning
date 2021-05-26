library application;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
  show
    kDebugMode,
    kProfileMode;

import 'package:get/get.dart'
  show GetMaterialApp;

import 'controllers/controllers.dart'
  show AppBinding;
import 'services/firebase/firebase.dart'
  show FirebaseService;
import 'utils/utils.dart'
  show
    AppText,
    AppTheme;
import 'views/views.dart'
  show IndexView;

class MobileApp extends StatelessWidget {
  /// start widget root app, run in main app.
  const MobileApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    GetMaterialApp(
      enableLog: kDebugMode,
      showPerformanceOverlay: kProfileMode,
      debugShowCheckedModeBanner: kDebugMode,
      logWriterCallback: (text, { isError = false }) {
        if ( isError ) {
          if ( text.isNotEmpty ) {
            debugPrint(text);
          }
        } else {
          debugPrint("Log: $text");
        }
      },
      initialBinding: AppBinding(),
      onInit: () async {
        await FirebaseService.instance
          .initial(debugMode: kDebugMode);
      },
      // onDispose: () {},
      title: AppText.app,
      /// Initial setting application theme
      /// [Brightness, Colors, TextTheme, AppBarTheme]
      /// [TextTheme] set at headline4 or display1
      /// used in the 2014 version of material design.
      /// [AppBarTheme] set appbar elevation.
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      /// The name of the first route to show,
      /// if a [Navigator] is built.
      /// (start with index page)
      home: const IndexView(),
    );
}