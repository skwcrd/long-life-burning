part of controller;

class NearbyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      NearbyController._(),
      tag: NearbyController.tag);
  }
}