import 'package:get/get.dart';

import 'index.dart';

class ImagePostController extends GetxController {
  ImagePostController();

  final state = ImagePostState();

  // tap
  void handleTap(int index) {
    Get.snackbar(
      "标题",
      "消息",
    );
  }

  Future<void> loadData() async {
    state.detailedPost.value = Get.arguments ??{};
  }

  void refreshUI() {
    loadData();
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
