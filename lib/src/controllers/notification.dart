part of controller;

class NotifyController extends GetxController {
  NotifyController._()
    : _id = 0,
      _message = Rxn(),
      _token = RxnString(),
      super();

  static const String tag = 'notification';

  int _id;

  final RxnString _token;
  final Rxn<RemoteMessage> _message;

  @override
  void onInit() {
    super.onInit();
    _token
      .bindStream(
        NotifyService.instance.token);

    _message
      ..bindStream(
        NotifyService.instance.message)
      ..bindStream(
        NotifyService.instance.messageOpenedApp);

    _registerStream();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {
    super.onClose();
    _token.close();
    _message.close();
  }

  String? get token =>
      _token.value;

  Stream<String> get tokenStream =>
      _token.stream
        .where((t) => t != null)
        .map((t) => t!)
        .where((t) => t.isNotEmpty)
        .asBroadcastStream();

  Stream<RemoteMessage> get messageStream =>
      _message.stream
        .where((t) => t != null)
        .map((t) => t!)
        .asBroadcastStream();

  Future<void> _registerStream() async {
    tokenStream
      .listen((token) {
      });

    messageStream
      .listen((message) {
        final _notify = message.notification;

        NotifyService.instance
          .show(
            id: _id++,
            title: _notify?.title,
            body: _notify?.body);
      });
  }
}