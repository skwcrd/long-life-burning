import 'package:flutter_test/flutter_test.dart';

import 'package:drive/drive.dart' as drive;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth_instance_e2e.dart';
import 'auth_test_utils.dart';
import 'auth_user_e2e.dart';

// Requires that an emulator is running locally
// `melos run firebase:emulator`
bool useEmulator = true;

void testsMain() {
  setUpAll(() async {
    await Firebase.initializeApp();
    if (useEmulator) {
      await FirebaseAuth.instance.useEmulator(
        'http://$testEmulatorHost:$testEmulatorPort');
    }
  });

  setUp(() async {
    // Reset users on emulator.
    await emulatorClearAllUsers();

    // Create a generic testing user account.
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: testEmail,
      password: testPassword,
    );

    // Create a disabled user account.
    final disabledUserCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: testDisabledEmail,
      password: testPassword,
    );
    await emulatorDisableUser(disabledUserCredential.user.uid);

    await ensureSignedOut();
  });

  runInstanceTests();
  runUserTests();
}

void main() => drive.main(testsMain);