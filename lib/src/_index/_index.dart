library _index;

import 'dart:io'
  show Platform;

import 'package:flutter/foundation.dart'
  show kIsWeb;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/controllers.dart'
  show
    AppController,
    WebController,
    DesktopController;

part 'app.dart';
part 'web.dart';
part 'desktop.dart';

class Index extends StatelessWidget {
  /// The index page in adaptive app for all platform.
  const Index({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ( kIsWeb ) {
      return _IndexWeb(key: key);
    } else if ( Platform.isAndroid || Platform.isIOS ) {
      return _IndexApp(key: key);
    }

    return _IndexDesktop(key: key);
  }
}