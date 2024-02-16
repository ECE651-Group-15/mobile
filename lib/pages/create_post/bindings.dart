import 'package:get/get.dart';

import 'controller.dart';

class CreatePostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePostController>(() => CreatePostController());
  }
}
