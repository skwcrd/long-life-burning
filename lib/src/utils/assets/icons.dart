part of util;

class AppIcon {
  AppIcon._();

  static const String _assets = 'assets/icons';

  static const String burn = '$_assets/burn.png';
  static const String distance = '$_assets/distance.png';
  static const String run = '$_assets/runner.png';

  static final IconData home =
      Platform.isAndroid ? _IconAndroid.home : _IconiOS.home;

  static final IconData nearby =
      Platform.isAndroid ? _IconAndroid.nearby : _IconiOS.nearby;

  static final IconData event =
      Platform.isAndroid ? _IconAndroid.event : _IconiOS.event;

  static final IconData group =
      Platform.isAndroid ? _IconAndroid.group : _IconiOS.group;

  static final IconData notify =
      Platform.isAndroid ? _IconAndroid.notify : _IconiOS.notify;

  static final IconData menu =
      Platform.isAndroid ? _IconAndroid.menu : _IconiOS.menu;
}

// Icons on Android
class _IconAndroid {
  _IconAndroid._();

  static const String _materialFamily = 'MaterialIcons';

  static const IconData home = IconData(
    0xe88a,
    fontFamily: _materialFamily,
  );

  static const IconData nearby = IconData(
    0xe569,
    fontFamily: _materialFamily,
  );

  static const IconData event = IconData(
    0xe878,
    fontFamily: _materialFamily,
  );

  static const IconData group = IconData(
    0xe7ef,
    fontFamily: _materialFamily,
  );

  static const IconData notify = IconData(
    0xe7f4,
    fontFamily: _materialFamily,
  );

  static const IconData menu = IconData(
    0xe5d2,
    fontFamily: _materialFamily,
  );
}

// Icons on iOS
class _IconiOS {
  _IconiOS._();

  static const String _cupertinoFamily = 'CupertinoIcons';

  static const IconData home = IconData(
    0xf38f,
    fontFamily: _cupertinoFamily,
  );

  static const IconData nearby = IconData(
    0xf474,
    fontFamily: _cupertinoFamily,
  );

  static const IconData event = IconData(
    0xf3f4,
    fontFamily: _cupertinoFamily,
  );

  static const IconData group = IconData(
    0xf47c,
    fontFamily: _cupertinoFamily,
  );

  static const IconData notify = IconData(
    0xf3e2,
    fontFamily: _cupertinoFamily,
  );

  static const IconData menu = IconData(
    0xf394,
    fontFamily: _cupertinoFamily,
  );
}