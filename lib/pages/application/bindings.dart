import 'package:exchange/pages/home/index.dart';
import 'package:exchange/pages/message/index.dart';
import 'package:exchange/pages/mine/index.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => MessageController());
    Get.lazyPut(() => MineController());
  }
}
