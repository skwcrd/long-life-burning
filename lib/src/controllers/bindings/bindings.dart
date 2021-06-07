part of controller;

class AppBinding extends Bindings {
  @override
  void dependencies() {
    if ( kIsWeb ) {
      Get.put(
        WebController._(),
        tag: WebController.tag,
        permanent: true);
    } else if ( Platform.isAndroid || Platform.isIOS ) {
      Get.put(
        AppController._(),
        tag: AppController.tag,
        permanent: true);
    } else {
      Get.put(
        DesktopController._(),
        tag: DesktopController.tag,
        permanent: true);
    }

    Get.put(
      AuthController._(),
      tag: AuthController.tag,
      permanent: true);
  }
}