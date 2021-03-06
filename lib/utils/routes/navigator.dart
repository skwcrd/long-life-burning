part of routing;

class NavCategory {

  NavCategory({
    @required this.name,
    this.icon,
    @required this.tag,
    GlobalKey<NavigatorState> navigatorKey,
  }) :  navigateKey = navigatorKey ?? GlobalKey<NavigatorState>(),
        assert(name != null);

  final String name;
  final IconData icon;
  final CategoryPage tag;
  final GlobalKey<NavigatorState> navigateKey;

  @override
  String toString() {
    return '$runtimeType($name)';
  }

}

class Pages {

  Pages({
    @required this.name,
    @required this.tag,
    @required this.routeName,
    @required this.buildRoute,
  }) :  assert(tag != null),
        assert(name != null),
        assert(routeName != null),
        assert(buildRoute != null);

  final String name;
  final CategoryPage tag;
  final String routeName;
  final WidgetBuilder buildRoute;

  @override
  String toString() {
    return '$runtimeType($name, $tag, $routeName, $buildRoute)';
  }

}

class PageNavigate extends StatelessWidget {

  PageNavigate({
    Key key,
    @required this.index,
  }) :  assert(index != null),
        super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) => Navigator(
    key: nav[index].navigateKey,
    initialRoute: Navigator.defaultRouteName,
    onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
      settings: settings,
      builder: _buildRoutePage(nav[index].tag)[settings.name],
    ),
    onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
      settings: settings,
      builder: (_) => NotFoundPage(),
    ),
  );

}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Not Found Page",
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
