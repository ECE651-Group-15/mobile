import 'package:get/get.dart';
import '../../common/apis/post.dart';
import '../../common/entities/post.dart';
import 'index.dart';

class MineController extends GetxController {
  MineController();

  final state = MineState();


  Future<Map<String, dynamic>?> getProfile() async {
    GetProfileRequestEntity req = GetProfileRequestEntity(
      customerId: state.userId,
    );
    Map<String, dynamic>? userProfile = {};
    // EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
    try {
      GetProfileResponseEntity res = await PostApi.getProfile(req);
      if (res.code == 200 && res.data != null) {
        userProfile = res.data!.toJson(); // 使用 Data 类的 toJson 方法
      } else {
        print('Error: getProfile()');
        userProfile = {};
      }
    } catch (e) {
      print('Error : $e');
      userProfile = {}; // 捕获异常时也确保返回一个空Map
    }
    return userProfile;
  }

  // tap
  void handleTap(int index) {
    Get.snackbar(
      "标题",
      "消息",
    );
  }

  void refreshUI(){
    // loadData();
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
    // loadData();
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
