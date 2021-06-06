part of _index;

class _IndexDesktop extends GetView<DesktopController> {
  /// The index page in app used for display desktop app menu selection.
  const _IndexDesktop({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Test Desktop'),
          ],
        ),
      ),
    );
}