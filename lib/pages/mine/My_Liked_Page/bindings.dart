import 'package:get/get.dart';

import 'Controller.dart';

class MyLikedPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyLikedPostController>(() => MyLikedPostController());
  }
}
