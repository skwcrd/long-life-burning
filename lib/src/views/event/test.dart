part of view.event;

class _TestView extends StatelessWidget {
  /// The test page in app.
  const _TestView({ Key? key }) : super(key: key);

  /// The route name or path test page.
  static const String routeName = '/event/test';

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Test View'),
      ),
      body: Center(
        child: Text(
          'Test',
          style: context.textTheme.headline6,
        ),
      ),
    );
}