import 'package:get/get.dart';

import 'controller.dart';

class MyProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProfileController>(() => MyProfileController());
  }
}