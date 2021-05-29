part of service.authentication;

class _AppleAuthService {
  _AppleAuthService._(this._delegate);

  final AuthService _delegate;

  Future<UserCredential> signin() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final _rawNonce = _generateNonce();
    final _nonce = _sha256ofString(_rawNonce);

    // Request credential for the currently signed in Apple account.
    final _appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: _nonce);

    // Create an `OAuthCredential` from the credential returned by Apple.
    final _credential = OAuthProvider("apple.com").credential(
      idToken: _appleCredential.identityToken,
      rawNonce: _rawNonce);

    return _delegate._signInWithCredential(
      credential: _credential);
  }

  Future<UserCredential> signInWeb() {
    // Create and configure an OAuthProvider for Sign In with Apple.
    final _provider = OAuthProvider("apple.com")
      ..addScope('email')
      ..addScope('name');

    // Sign in the user with Firebase.
    return _delegate._signInWithPopup(
      provider: _provider);
  }

  /// Generates a cryptographically secure random nonce,
  /// to be included in a credential request.
  String _generateNonce([ int _length = 32 ]) {
    const _charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final _random = Random.secure();

    return List.generate(
        _length,
        (_) => _charset[_random.nextInt(_charset.length)])
      .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final _byte = utf8.encode(input);
    final _digest = sha256.convert(_byte);

    return _digest.toString();
  }
}