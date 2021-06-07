part of controller;

class NotifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      NotifyController._(),
      tag: NotifyController.tag);
  }
}