part of controller;

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AppController._(),
      permanent: true);
    Get.put(
      AuthController._(),
      permanent: true);
  }
}