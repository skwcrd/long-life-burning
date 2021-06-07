library application;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
  show
    kIsWeb,
    kDebugMode,
    kProfileMode;
import 'package:flutter_gen/gen_l10n/localizations.dart'
  show AppLocalizations;

import 'package:get/get.dart'
  show
    Transition,
    GetMaterialApp;

import '_index/_index.dart'
  show Index;
import 'controllers/controllers.dart'
  show AppBinding;
import 'utils/utils.dart'
  show
    AppText,
    AppTheme;

class App extends StatelessWidget {
  /// start widget root app, run in main app.
  const App({ Key? key }) : super(key: key);

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
      // onInit: () {},
      // onDispose: () {},
      title: AppText.app,
      /// Initial setting application theme.
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      /// The name of the first route to show,
      /// if a [Navigator] is built.
      /// (start with index page)
      home: const Index(),
      defaultTransition: kIsWeb
        ? Transition.noTransition
        : Transition.native,
      /// The initial locale for this app's [Localizations] widget
      /// is based on this value.
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      /// The list of locales that this app has been localized for.
      supportedLocales: AppLocalizations.supportedLocales,
      /// The delegates collectively define all of the localized resources
      /// for this application's [Localizations] widget.
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
}