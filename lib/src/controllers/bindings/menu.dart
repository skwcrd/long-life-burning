part of controller;

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      MenuController._(),
      tag: MenuController.tag);
  }
}