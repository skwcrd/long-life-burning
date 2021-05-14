part of service.firebase;

class _AuthService {
  _AuthService._()
    : _auth = FirebaseAuth.instance;

  final FirebaseAuth _auth;

  Stream<User> get authStateChanges =>
      _auth.authStateChanges();

  Future<void> signin({
    @required String email,
    @required String password,
    int timeout = 10,
  }) async {
    await _auth
      .signInWithEmailAndPassword(
        email: email,
        password: password)
      .timeout(
        Duration(seconds: timeout),
        onTimeout: () {
          throw FirebaseService.error.onTimeout(
            message: "FirebaseAuth cannot signin",
            duration: Duration(seconds: timeout),
            stack: StackTrace.current);
        });
  }

  Future<void> signup({
    @required String email,
    @required String password,
    String name = '',
    int timeout = 10,
  }) async {
    final _credential = await _auth
      .createUserWithEmailAndPassword(
        email: email,
        password: password)
      .timeout(
        Duration(seconds: timeout),
        onTimeout: () {
          throw FirebaseService.error.onTimeout(
            message: "FirebaseAuth cannot signup",
            duration: Duration(seconds: timeout),
            stack: StackTrace.current);
        });

    await _credential.user.updateProfile(
      displayName: name);

    await signout();
  }

  Future<void> signout() async {
    await _auth.signOut();
  }
}