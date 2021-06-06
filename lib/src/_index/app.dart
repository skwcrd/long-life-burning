part of _index;

class _IndexApp extends GetView<AppController> {
  /// The index page in app used for display menu selection.
  const _IndexApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    ObxValue<RxInt>(
      (index) => WillPopScope(
        onWillPop: () async => !await Get.global(
          controller.id[index.value]).currentState!.maybePop<Object>(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: controller.pageItems,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index.value,
            items: controller.navItems,
            onTap: index,
          ),
        ),
      ),
      controller.index,
    );
}