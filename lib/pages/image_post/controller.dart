import 'package:exchange/pages/home/controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../common/apis/post.dart';
import '../../common/entities/post.dart';
import '../../common/routes/names.dart';
import '../../common/store/user.dart';
import '../My_Liked_Page/controller.dart';
import 'index.dart';

class ImagePostController extends GetxController {
  ImagePostController();
  HomeController homeController = Get.find<HomeController>();
  final state = ImagePostState();
  UserStore userStore = Get.find<UserStore>();
  // final Map<String, dynamic> profilesDetails = Get.arguments;

  void startConversation(var arguments) {
    if (UserStore.to.customerProfilesDetails.isEmpty) {
      EasyLoading.showInfo('Please login first');
      return;
    }

    Get.toNamed(AppRoutes.chat, arguments: arguments);
  }

  Future<void> starListing(String listingId) async {
    StarListingRequestEntity req = StarListingRequestEntity(
      customerId: userStore.customerProfilesDetails['id'],
      listingId: listingId,
    );

    try {
      StarListingResponseEntity res = await PostApi.starPost(req);
      if (res.code == 200) {
        EasyLoading.showSuccess('star post success');
        userStore.customerProfilesDetails['starredListIds'].add(listingId);
        homeController.state.staredLists.add(listingId);
        state.isStared.value = true;
        // state.staredLists.add(listingId);
      } else {
        EasyLoading.showError('star post failed, try later');
      }
      // print(res.toJson());
    } catch (e) {
      EasyLoading.showError('Error: $e star post failed, try later');
    }
  }

  Future<void> unStarListing(String listingId) async {
    UnstarPostRequestEntity req = UnstarPostRequestEntity(
      customerId: userStore.customerProfilesDetails['id'],
      listingId: listingId,
    );

    try {
      UnstarPostResponseEntity res = await PostApi.unStarPost(req);
      if (res.code == 200) {
        EasyLoading.showSuccess('unstar post success');
        userStore.customerProfilesDetails['starredListIds'].remove(listingId);
        homeController.state.staredLists.remove(listingId);
        state.isStared.value = false;
        // state.staredLists.remove(listingId);
      } else {
        EasyLoading.showError('unstar post failed, try later');
      }
      // print(res.toJson());
    } catch (e) {
      EasyLoading.showError('Error : $e unstar post failed, try later');
    }
  }

  void checkIfStared() {
    if (userStore.isLogin) {
      state.isStared.value = userStore.customerProfilesDetails['starredListIds']
          .contains(state.listingId);
    } else {
      state.isStared.value = false;
    }
  }

  Future<void> loadData() async {
    state.detailedPost.value = Get.arguments ?? {};
    state.listingId = state.detailedPost.value['listingDetails']?['id'] ?? "";
    checkIfStared();
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
