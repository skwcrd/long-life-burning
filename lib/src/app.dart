library app;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
  show
    kDebugMode,
    kProfileMode;

import 'package:get/get.dart'
  show
    GetPage,
    Transition,
    GetMaterialApp;

import 'controllers/controllers.dart'
  show AppBinding;
import 'services/firebase/firebase.dart';
import 'utils/utils.dart'
  show
    AppText,
    AppTheme;
import 'views/views.dart';

part 'route.dart';

class App extends StatelessWidget {
  /// start widget root app, run in main.
  const App({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    GetMaterialApp(
      enableLog: kDebugMode,
      showPerformanceOverlay: kProfileMode,
      debugShowCheckedModeBanner: kDebugMode,
      logWriterCallback: (text, { isError }) {
        if ( isError ?? false ) {
          if ( (text != null) && (text.isNotEmpty) ) {
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
      navigatorObservers: <NavigatorObserver>[
        FirebaseService.observer,
      ],
      /// Initial setting application theme
      /// [Brightness, Colors, TextTheme, AppBarTheme]
      /// [TextTheme] set at headline4 or display1
      /// used in the 2014 version of material design.
      /// [AppBarTheme] set appbar elevation.
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      /// The application's top-level routing table.
      /// [routes] routing other pages in application.
      /// can edit [routeName] in class define on page class.
      getPages: AppRoute.pages,
      defaultTransition: Transition.rightToLeft,
      /// The name of the first route to show,
      /// if a [Navigator] is built.
      /// (start with index page)
      initialRoute: AppRoute.index,
    );
}