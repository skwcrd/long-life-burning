part of util;

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData.light()
      .copyWith(
        // This makes the visual density adapt to the platform
        // that you run the app on. For desktop platforms,
        // the controls will be smaller and closer together
        // (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 2,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black38,
          type: BottomNavigationBarType.fixed,
        ),
      );

  static ThemeData get dark => ThemeData.dark()
      .copyWith(
        // This makes the visual density adapt to the platform
        // that you run the app on. For desktop platforms,
        // the controls will be smaller and closer together
        // (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 2,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white38,
          type: BottomNavigationBarType.fixed,
        ),
      );
}