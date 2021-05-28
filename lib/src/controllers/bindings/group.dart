part of controller;

class GroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GroupController._(),
      permanent: true);
  }
}