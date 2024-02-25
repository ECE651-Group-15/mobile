import 'package:get/get.dart';

import 'controller.dart';

class EditPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPostController>(() => EditPostController());
  }
}
