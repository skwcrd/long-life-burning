part of view;

class IndexView extends GetView<AppController> {
  /// The index page in app used for display menu selection
  /// into setting modes.
  const IndexView({ Key key }) : super(key: key);

  /// The route name or path root index page or main page.
  /// that the embedder requested when the application
  /// was launched.
  ///
  /// This will be the string "/" if no particular route
  /// was requested.
  static const String routeName = Navigator.defaultRouteName;

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.index,
          items: controller.navItems,
          onTap: controller.changeIndex,
        )),
    );
}