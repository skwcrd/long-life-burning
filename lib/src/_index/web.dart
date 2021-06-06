part of _index;

class _IndexWeb extends GetView<WebController> {
  /// The index page in app used for display web app menu selection.
  const _IndexWeb({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Test Web'),
          ],
        ),
      ),
    );
}