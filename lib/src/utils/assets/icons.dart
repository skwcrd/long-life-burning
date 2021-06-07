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

  static const String _iconFont = 'MaterialIcons';

  static const IconData home = IconData(
    0xe318,
    fontFamily: _iconFont);

  static const IconData nearby = IconData(
    0xe498,
    fontFamily: _iconFont);

  static const IconData event = IconData(
    0xe241,
    fontFamily: _iconFont,
    matchTextDirection: true);

  static const IconData group = IconData(
    0xe2ee,
    fontFamily: _iconFont);

  static const IconData notify = IconData(
    0xe44f,
    fontFamily: _iconFont);

  static const IconData menu = IconData(
    0xe3dc,
    fontFamily: _iconFont);
}

// Icons on iOS
class _IconiOS {
  _IconiOS._();

  /// The icon font used for Cupertino icons.
  static const String _iconFont = 'CupertinoIcons';

  /// The dependent package providing the Cupertino icons font.
  static const String _iconFontPackage = 'cupertino_icons';

  static const IconData home = IconData(
    0xf447,
    fontFamily: _iconFont,
    fontPackage: _iconFontPackage);

  static const IconData nearby = IconData(
    0xf455,
    fontFamily: _iconFont,
    fontPackage: _iconFontPackage);

  static const IconData event = IconData(
    0xf8b6,
    fontFamily: _iconFont,
    fontPackage: _iconFontPackage);

  static const IconData group = IconData(
    0xf47c,
    fontFamily: _iconFont,
    fontPackage: _iconFontPackage);

  static const IconData notify = IconData(
    0xf3e2,
    fontFamily: _iconFont,
    fontPackage: _iconFontPackage);

  static const IconData menu = IconData(
    0xf8b1,
    fontFamily: _iconFont,
    fontPackage: _iconFontPackage);
}