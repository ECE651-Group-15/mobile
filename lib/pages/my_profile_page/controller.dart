import 'package:exchange/common/apis/post.dart';
import 'package:exchange/common/entities/post.dart';
import 'package:exchange/common/store/user.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'index.dart';

class MyProfileController extends GetxController {

  final state = MyProfileControllerState();
  UserStore userStore = Get.find<UserStore>();

  Future<bool> deleteAccount() async {
// Update request entity to include the selected avatar
    DeleteUserRequestEntity req = DeleteUserRequestEntity(
        profileId: userStore.customerProfilesDetails['id']);
    try {
      EasyLoading.show(status: 'Updating profile...');
      DeleteUserResponseEntity res = await PostApi.deleteUser(req);
      if (res.code == 200 && res.data != null) {
        EasyLoading.showSuccess('Profile updated successfully');
// Update local user profile data if necessary
        userStore.isLogin = false;
        return true;
      } else {
        EasyLoading.showError('Update failed: ');
        return false;
      }
    } catch (e) {
      print('Error : $e');
      EasyLoading.showError('Update failed: $e');
      return false;
    }
  }

  void loadData() {
    state.customerProfilesDetails =
        userStore.customerProfilesDetails;
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
