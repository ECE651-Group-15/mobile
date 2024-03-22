import 'package:get/get.dart';

import 'controller.dart';

class CompletedOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedOrderController>(() => CompletedOrderController());
  }
}
