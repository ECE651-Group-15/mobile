
import 'package:get/get.dart';
import '../home/controller.dart';
import 'index.dart';

class MyProfileController extends GetxController{
  MyProfileController();

  final state = MyProfileControllerState();
  final HomeController homeController = Get.find<HomeController>();

  void loadData(){
    state.customerProfilesDetails = homeController.state.customerProfilesDetails;
  }
  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }
}