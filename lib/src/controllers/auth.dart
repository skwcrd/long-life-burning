part of controller;

typedef _AuthErrorCallback = void Function(
  Object? error,
  FirebaseAuthException? exception,
  StackTrace stackTrace,
);

class AuthController extends GetxController {
  AuthController._()
    : _user = Rxn<User>(),
      super();

  static const String tag = 'auth';

  final Rxn<User> _user;

  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(
      AuthService.instance.authStateChanges);
  }

  @override
  void onClose() {
    super.onClose();
    _user.close();
  }

  Future<bool> signin({
    required String email,
    required String password,
    _AuthErrorCallback? onError,
    int timeout = 10,
  }) async {
    try {
      await AuthService.instance
        .signin(
          email: email,
          password: password,
          timeout: timeout);

      return true;
    } on FirebaseAuthException catch (error, stackTrace) {
      ReportService.error.exception(
        message: "Failed at signin with error "
          "code: ${error.code} and message: ${error.message}.",
        error: error,
        stack: stackTrace);

      onError?.call(
        null, error, stackTrace);
    } catch (error, stackTrace) {
      ReportService.error.exception(
        message: "The signin method has something wrong.",
        error: error,
        stack: stackTrace);

      onError?.call(
        error, null, stackTrace);
    }

    return false;
  }

  Future<bool> signInWithGoogle({
    _AuthErrorCallback? onError,
    int timeout = 10,
  }) async {
    try {
      await AuthService.instance
        .signInWithGoogle(
          timeout: timeout);

      return true;
    } on FirebaseAuthException catch (error, stackTrace) {
      ReportService.error.exception(
        message: "Failed at google signin with error "
          "code: ${error.code} and message: ${error.message}.",
        error: error,
        stack: stackTrace);

      onError?.call(
        null, error, stackTrace);
    } catch (error, stackTrace) {
      ReportService.error.exception(
        message: "The google signin method has something wrong.",
        error: error,
        stack: stackTrace);

      onError?.call(
        error, null, stackTrace);
    }

    return false;
  }

  Future<bool> signInWithAppleID({
    _AuthErrorCallback? onError,
    int timeout = 10,
  }) async {
    try {
      await AuthService.instance
        .signInWithAppleID(
          timeout: timeout);

      return true;
    } on FirebaseAuthException catch (error, stackTrace) {
      ReportService.error.exception(
        message: "Failed at apple signin with error "
          "code: ${error.code} and message: ${error.message}.",
        error: error,
        stack: stackTrace);

      onError?.call(
        null, error, stackTrace);
    } catch (error, stackTrace) {
      ReportService.error.exception(
        message: "The apple signin method has something wrong.",
        error: error,
        stack: stackTrace);

      onError?.call(
        error, null, stackTrace);
    }

    return false;
  }

  Future<bool> signup({
    required String email,
    required String password,
    String name = '',
    _AuthErrorCallback? onError,
    int timeout = 10,
  }) async {
    try {
      await AuthService.instance
        .signup(
          name: name,
          email: email,
          password: password,
          timeout: timeout);

      return true;
    } on FirebaseAuthException catch (error, stackTrace) {
      ReportService.error.exception(
        message: "Failed at signup with error "
          "code: ${error.code} and message: ${error.message}.",
        error: error,
        stack: stackTrace);

      onError?.call(
        null, error, stackTrace);
    } catch (error, stackTrace) {
      ReportService.error.exception(
        message: "The signup method has something wrong.",
        error: error,
        stack: stackTrace);

      onError?.call(
        error, null, stackTrace);
    }

    return false;
  }

  Future<bool> signout({
    _AuthErrorCallback? onError,
  }) async {
    try {
      await AuthService.instance.signout();

      return true;
    } on FirebaseAuthException catch (error, stackTrace) {
      ReportService.error.exception(
        message: "Failed at signout with error "
          "code: ${error.code} and message: ${error.message}.",
        error: error,
        stack: stackTrace);

      onError?.call(
        null, error, stackTrace);
    } catch (error, stackTrace) {
      ReportService.error.exception(
        message: "The signout method has something wrong.",
        error: error,
        stack: stackTrace);

      onError?.call(
        error, null, stackTrace);
    }

    return false;
  }
}