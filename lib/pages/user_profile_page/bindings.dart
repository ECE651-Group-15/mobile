import 'package:get/get.dart';

import 'controller.dart';

class UserProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(() => UserProfileController());
  }
}