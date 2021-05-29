part of service.authentication;

class _GoogleAuthService {
  _GoogleAuthService._(this._delegate)
    : _provider = GoogleAuthProvider(),
      _signin = GoogleSignIn.standard(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/fitness.activity.read',
        ]) {
          // Create a new provider
          _provider
            ..addScope('email')
            ..addScope('https://www.googleapis.com/auth/fitness.activity.read')
            ..setCustomParameters({
              'login_hint': 'user@example.com'
            });
        }

  final AuthService _delegate;

  final GoogleSignIn _signin;
  final GoogleAuthProvider _provider;

  Future<UserCredential> signin() async {
    // Trigger the authentication flow
    final _googleUser = await _signin.signIn();

    // Obtain the auth details from the request
    final _googleAuth = await _googleUser?.authentication;

    // Create a new credential
    final _credential = GoogleAuthProvider.credential(
      accessToken: _googleAuth?.accessToken,
      idToken: _googleAuth?.idToken);

    return _delegate._signInWithCredential(
      credential: _credential);
  }

  Future<UserCredential> signInWeb() =>
      // Once signed in, return the UserCredential
      _delegate._signInWithPopup(
        provider: _provider);

      // Or use signInWithRedirect
      // _delegate._signInWithRedirect(
      //   provider: _provider);
}