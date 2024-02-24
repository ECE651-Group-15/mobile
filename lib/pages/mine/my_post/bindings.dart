import 'package:get/get.dart';

import 'controller.dart';

class MyPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPostController>(() => MyPostController());
  }
}