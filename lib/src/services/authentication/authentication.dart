library service.authentication;

import 'dart:convert'
  show utf8;
import 'dart:math'
  show Random;

import 'package:crypto/crypto.dart'
  show sha256;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart'
  show AuthProvider;
import 'package:google_sign_in/google_sign_in.dart'
  show GoogleSignIn;
import 'package:sign_in_with_apple/sign_in_with_apple.dart'
  show
    SignInWithApple,
    AppleIDAuthorizationScopes;

import '../firebase/firebase.dart';

part 'apple.dart';
part 'google.dart';

class AuthService {
  AuthService._()
    : _auth = FirebaseAuth.instance;

  static AuthService? _instance;
  static _GoogleAuthService? _googleInstance;
  static _AppleAuthService? _appleInstance;

  /// Singleton instance of AuthService.
  // ignore: prefer_constructors_over_static_methods
  static AuthService get instance =>
      _instance ??= AuthService._();

  /// Singleton instance of GoogleAuthService.
  static _GoogleAuthService get _google =>
      _googleInstance ??= _GoogleAuthService._(instance);

  /// Singleton instance of AppleAuthService.
  static _AppleAuthService get _apple =>
      _appleInstance ??= _AppleAuthService._(instance);

  final FirebaseAuth _auth;

  /// Notifies about changes to the user's sign-in state
  /// (such as sign-in or sign-out).
  Stream<User?> get authStateChanges =>
      _auth.authStateChanges();

  /// Attempts to sign in a user with the given email address and password.
  ///
  /// If successful, it also signs the user in into the app and updates
  /// any [authStateChanges] stream listeners.
  ///
  /// **Important**: You must enable Email & Password accounts in the Auth
  /// section of the Firebase console before being able to use them.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **invalid-email**:
  ///   - Thrown if the email address is not valid.
  /// - **user-disabled**:
  ///   - Thrown if the user corresponding to the given email has been disabled.
  /// - **user-not-found**:
  ///   - Thrown if there is no user corresponding to the given email.
  /// - **wrong-password**:
  ///   - Thrown if the password is invalid for the given email, or the account
  ///     corresponding to the email does not have a password set.
  Future<UserCredential> signin({
    required String email,
    required String password,
    int timeout = 10,
  }) =>
      _auth
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

  Future<UserCredential> signInWithGoogle({
    int timeout = 10,
  }) =>
      _google
        .signin()
        .timeout(
          Duration(seconds: timeout),
          onTimeout: () {
            throw FirebaseService.error.onTimeout(
              message: "FirebaseAuth cannot signin with google",
              duration: Duration(seconds: timeout),
              stack: StackTrace.current);
          });

  Future<UserCredential> signInWithAppleID({
    int timeout = 10,
  }) =>
      _apple
        .signin()
        .timeout(
          Duration(seconds: timeout),
          onTimeout: () {
            throw FirebaseService.error.onTimeout(
              message: "FirebaseAuth cannot signin with apple id",
              duration: Duration(seconds: timeout),
              stack: StackTrace.current);
          });

  /// Tries to create a new user account with the given email address and
  /// password.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **email-already-in-use**:
  ///   - Thrown if there already exists an account with the given email address.
  /// - **invalid-email**:
  ///   - Thrown if the email address is not valid.
  /// - **operation-not-allowed**:
  ///   - Thrown if email/password accounts are not enabled. Enable
  ///     email/password accounts in the Firebase Console, under the Auth tab.
  /// - **weak-password**:
  ///   - Thrown if the password is not strong enough.
  Future<void> signup({
    required String email,
    required String password,
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

    await _credential.user!.updateProfile(
      displayName: name);

    await signout();
  }

  /// Signs out the current user.
  ///
  /// If successful, it also updates
  /// any [authStateChanges] stream listeners.
  Future<void> signout() =>
      _auth.signOut();

  /// Returns a list of sign-in methods that can be used to sign in a given
  /// user (identified by its main email address).
  ///
  /// This method is useful when you support multiple authentication mechanisms
  /// if you want to implement an email-first authentication flow.
  ///
  /// An empty `List` is returned if the user could not be found.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **invalid-email**:
  ///   - Thrown if the email address is not valid.
  Future<List<String>> fetchSignInMethod({
    required String email,
  }) => _auth.fetchSignInMethodsForEmail(email);

  /// Asynchronously signs in to Firebase with the given 3rd-party credentials
  /// (e.g. a Facebook login Access Token, a Google ID Token/Access Token pair,
  /// etc.) and returns additional identity provider data.
  ///
  /// If successful, it also signs the user in into the app and updates
  /// any [authStateChanges] stream listeners.
  ///
  /// If the user doesn't have an account already, one will be created
  /// automatically.
  ///
  /// **Important**: You must enable the relevant accounts in the Auth section
  /// of the Firebase console before being able to use them.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **account-exists-with-different-credential**:
  ///   - Thrown if there already exists an account with the email address
  ///     asserted by the credential.
  ///     Resolve this by calling [fetchSignInMethodsForEmail] and then asking
  ///     the user to sign in using one of the returned providers.
  ///     Once the user is signed in, the original credential can be linked to
  ///     the user with [linkWithCredential].
  /// - **invalid-credential**:
  ///   - Thrown if the credential is malformed or has expired.
  /// - **operation-not-allowed**:
  ///   - Thrown if the type of account corresponding to the credential is not
  ///     enabled. Enable the account type in the Firebase Console, under the
  ///     Auth tab.
  /// - **user-disabled**:
  ///   - Thrown if the user corresponding to the given credential has been
  ///     disabled.
  /// - **user-not-found**:
  ///   - Thrown if signing in with a credential from [EmailAuthProvider.credential]
  ///     and there is no user corresponding to the given email.
  /// - **wrong-password**:
  ///   - Thrown if signing in with a credential from [EmailAuthProvider.credential]
  ///     and the password is invalid for the given email, or if the account
  ///     corresponding to the email does not have a password set.
  /// - **invalid-verification-code**:
  ///   - Thrown if the credential is a [PhoneAuthProvider.credential] and the
  ///     verification code of the credential is not valid.
  /// - **invalid-verification-id**:
  ///   - Thrown if the credential is a [PhoneAuthProvider.credential] and the
  ///     verification ID of the credential is not valid.id.
  Future<UserCredential> _signInWithCredential({
    required AuthCredential credential,
  }) => _auth.signInWithCredential(credential);

  /// Authenticates a Firebase client using a popup-based
  /// OAuth authentication flow.
  ///
  /// If succeeds, returns the signed in user along with
  /// the provider's credential.
  ///
  /// This method is only available on web based platforms.
  Future<UserCredential> _signInWithPopup({
    required AuthProvider provider,
  }) => _auth.signInWithPopup(provider);

  /// Authenticates a Firebase client using a full-page redirect flow.
  ///
  /// To handle the results and errors for this operation, refer to
  /// [getRedirectResult].
  // Future<void> _signInWithRedirect({
  //   required AuthProvider provider,
  // }) => _auth.signInWithRedirect(provider);

  /// Returns a UserCredential from the redirect-based sign-in flow.
  ///
  /// If sign-in succeeded, returns the signed in user. If sign-in was
  /// unsuccessful, fails with an error. If no redirect operation was called,
  /// returns a [UserCredential] with a null User.
  ///
  /// This method is only support on web platforms.
  // Future<UserCredential> _getRedirectResult() =>
  //     _auth.getRedirectResult();
}