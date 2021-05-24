library service.firebase;

import 'dart:async'
  show TimeoutException;

import 'package:flutter/foundation.dart'
  show
    // debugPrint,
    FlutterError,
    ErrorDescription,
    TextTreeRenderer,
    FlutterErrorDetails,
    DiagnosticsTreeStyle;

import 'package:get/get.dart'
  show Get;

import 'package:firebase_analytics/observer.dart'
  show FirebaseAnalyticsObserver;
import 'package:firebase_auth/firebase_auth.dart'
  show
    User,
    FirebaseAuth;
// import 'package:cloud_firestore/cloud_firestore.dart'
//   show FirebaseFirestore;
import 'package:firebase_analytics/firebase_analytics.dart'
  show FirebaseAnalytics;
import 'package:firebase_crashlytics/firebase_crashlytics.dart'
  show FirebaseCrashlytics;

import '../../utils/utils.dart'
  show AppText;

part 'db.dart';
part 'auth.dart';
part 'error.dart';

class FirebaseService {
  FirebaseService._();

  static FirebaseService? _instance;

  /// Singleton instance of FirebaseService.
  // ignore: prefer_constructors_over_static_methods
  static FirebaseService get instance =>
      _instance ??= FirebaseService._();

  static _AuthService? _auth;

  /// Singleton instance of AuthService.
  static _AuthService get auth =>
      _auth ??= _AuthService._();

  static _ErrorService? _error;

  /// Singleton instance of ErrorService.
  static _ErrorService get error =>
      _error ??= _ErrorService._();

  // static _DatabaseService? _db;

  /// Singleton instance of DatabaseService.
  // static _DatabaseService get db =>
  //     _db ??= _DatabaseService._();

  static FirebaseAnalyticsObserver? _observer;

  /// Singleton instance of FirebaseAnalyticsObserver.
  static FirebaseAnalyticsObserver get observer =>
    _observer ??= FirebaseAnalyticsObserver(
      analytics: FirebaseAnalytics(),
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

  /// Singleton instance of FirebaseAnalytics.
  static FirebaseAnalytics get analytic =>
      observer.analytics;

  Future<void> initial({ bool debugMode = false }) async {
    await error.init(
      debugMode: debugMode);
  }
}