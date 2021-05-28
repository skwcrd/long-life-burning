part of controller;

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      HomeController._(),
      permanent: true);
  }
}