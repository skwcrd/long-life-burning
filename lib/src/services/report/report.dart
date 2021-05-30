library service.report;

import 'dart:async'
  show TimeoutException;

import 'package:flutter/foundation.dart'
  show
    FlutterError,
    ErrorDescription,
    TextTreeRenderer,
    FlutterErrorDetails,
    DiagnosticsTreeStyle;

import 'package:get/get.dart'
  show Get;

import 'package:firebase_analytics/observer.dart'
  show FirebaseAnalyticsObserver;
import 'package:firebase_analytics/firebase_analytics.dart'
  show FirebaseAnalytics;
import 'package:firebase_crashlytics/firebase_crashlytics.dart'
  show FirebaseCrashlytics;

import '../../utils/utils.dart'
  show AppText;

part 'error.dart';

class ReportService {
  ReportService._();

  static ReportService? _instance;

  /// Singleton instance of ReportService.
  // ignore: prefer_constructors_over_static_methods
  static ReportService get instance =>
      _instance ??= ReportService._();

  static _ErrorService? _error;

  /// Singleton instance of ErrorService.
  static _ErrorService get error =>
      _error ??= _ErrorService._();

  static FirebaseAnalytics? _analytics;

  /// Singleton instance of FirebaseAnalytics.
  static FirebaseAnalytics get analytics =>
      _analytics ??= FirebaseAnalytics();

  /// Singleton instance of FirebaseAnalyticsObserver.
  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(
        analytics: analytics,
        onError: (err) {
          FlutterError.reportError(
            error.getErrorDetails(
              message: err.message ?? '',
              error: err,
              stack: StackTrace.fromString(
                err.stacktrace ?? ''),
            ));
        },
      );

  Future<void> initial({ bool debugMode = false }) async {
    /// You could additionally extend this to allow users to opt-in.
    ///
    /// Force enable analytics collection while doing every day
    /// development in non-debug builds.
    analytics.setAnalyticsCollectionEnabled(!debugMode);

    await error.init(
      debugMode: debugMode);
  }
}