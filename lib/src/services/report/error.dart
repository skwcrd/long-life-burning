part of service.report;

class _ErrorService {
  _ErrorService._()
    : _crashlytic = FirebaseCrashlytics.instance;

  final FirebaseCrashlytics _crashlytic;

  Future<void> _init({ bool debugMode = false }) async {
    /// You could additionally extend this to allow users to opt-in.
    ///
    /// Force enable crashlytics collection while doing every day
    /// development in non-debug builds.
    ///
    /// Temporarily toggle this to true
    /// if you want to test crash reporting in your app.
    await _crashlytic
        .setCrashlyticsCollectionEnabled(!debugMode);

    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = onError;

    await _checkUnsentReports();
  }

  Future<void> _checkUnsentReports() async {
    final _unsent = await _crashlytic.checkForUnsentReports();

    if ( _unsent ) {
      await _crashlytic.sendUnsentReports();
    }
  }

  void onError(FlutterErrorDetails details) {
    Get.log(
      TextTreeRenderer(
        wrapWidthProperties: 100,
        maxDescendentsTruncatableNode: 5)
      .render(
        details.toDiagnosticsNode(
          name: "${AppText.app} ${AppText.version}",
          style: DiagnosticsTreeStyle.error))
      .trim(),
      isError: true);

    _crashlytic.recordFlutterError(details);
  }

  void exception({
    required String message,
    Object? error,
    StackTrace? stack,
  }) {
    FlutterError.reportError(
      getErrorDetails(
        message: message,
        error: error,
        stack: stack));
  }

  TimeoutException onTimeout({
    required String message,
    Duration? duration,
    StackTrace? stack,
  }) {
    final _exception = TimeoutException(
      message, duration);

    FlutterError.reportError(
      getErrorDetails(
        message: message,
        error: _exception,
        stack: stack));

    return _exception;
  }

  FlutterErrorDetails getErrorDetails({
    required String message,
    Object? error,
    StackTrace? stack,
  }) => FlutterErrorDetails(
          exception: error ?? Exception(message),
          stack: stack ?? StackTrace.empty,
          library: "${AppText.app} Exception",
          context: ErrorDescription(message));
}