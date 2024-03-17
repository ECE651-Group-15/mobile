import 'package:get/get.dart';
import '../../common/store/user.dart';
import 'index.dart';

class ImagePostController extends GetxController {
  ImagePostController();

  final state = ImagePostState();
  UserStore userStore = Get.find<UserStore>();

  // tap
  void handleTap(int index) {
    Get.snackbar(
      "标题",
      "消息",
    );
  }

  void checkIfStared(String listingId) {
    if (userStore.isLogin) {
      state.isStared.value = userStore.customerProfilesDetails['starredListIds'].contains(listingId);
    } else {
      state.isStared.value = false;
    }
  }

  Future<void> loadData() async {
    state.detailedPost.value = Get.arguments ??{};
    checkIfStared(state.detailedPost.value['listingDetails']?['id']??"");
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
