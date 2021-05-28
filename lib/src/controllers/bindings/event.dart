part of controller;

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      EventController._(),
      permanent: true);
  }
}