import 'package:flutter_test/flutter_test.dart';
import 'package:drive/drive.dart' as drive;

import 'package:firebase_core/firebase_core.dart';

import 'messaging_instance_e2e.dart';

// Requires that an emulator is running locally
const bool USE_EMULATOR = false;

void testsMain() {
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  runInstanceTests();
}

void main() => drive.main(testsMain);