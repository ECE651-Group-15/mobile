import 'package:get/get.dart';

import 'controller.dart';

class SearchMainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchMainController>(() => SearchMainController());
  }
}
