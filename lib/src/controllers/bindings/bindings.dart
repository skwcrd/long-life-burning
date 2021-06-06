part of controller;

class AppBinding extends Bindings {
  @override
  void dependencies() {
    if ( kIsWeb ) {
      Get.put(
        WebController._(),
        permanent: true);
    } else if ( Platform.isAndroid || Platform.isIOS ) {
      Get.put(
        AppController._(),
        permanent: true);
    } else {
      Get.put(
        DesktopController._(),
        permanent: true);
    }

    Get.put(
      AuthController._(),
      permanent: true);
  }
}