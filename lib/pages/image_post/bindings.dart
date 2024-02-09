import 'package:get/get.dart';

import 'controller.dart';

class ImagePostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImagePostController>(() => ImagePostController());
  }
}
