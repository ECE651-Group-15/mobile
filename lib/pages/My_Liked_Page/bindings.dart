import 'package:get/get.dart';

import 'controller.dart';

class MyLikedPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyLikedPostController>(() => MyLikedPostController());
  }
}
