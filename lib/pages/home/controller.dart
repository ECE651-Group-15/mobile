import 'package:exchange/common/apis/post.dart';
import 'package:exchange/common/entities/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../common/store/user.dart';
import 'index.dart';

class HomeController extends GetxController {
  UserStore userStore = Get.find<UserStore>();
  var scrollController = ScrollController();
  var currentPage = 0.obs;
  var isStared = false.obs;
  HomeController();
  final state = HomeState();

  Future<void> fetchPostedListings(int n) async {
    FetchPostedListingsRequestEntity req = FetchPostedListingsRequestEntity(
      page: n,
    );
    try {
      FetchPostedListingsResponseEntity response = await PostApi.fetchListings(req);
      if (response.code == 200 && response.data != null && response.data!.listingDetails != null) {
        if (n != 0) {
          state.listings.addAll(response.data!.listingDetails!);
        } else {
          state.listings.assignAll(response.data!.listingDetails!);
        }
        EasyLoading.dismiss();
        update(); // Calling update to refresh the UI
      } else {
        EasyLoading.showError('Failed to fetch listings');
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
    }
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
        state.staredLists.add(listingId);
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
        state.staredLists.remove(listingId);
      } else {
        EasyLoading.showError('unstar post failed, try later');
      }
      // print(res.toJson());
    } catch (e) {
      EasyLoading.showError('Error : $e unstar post failed, try later');
    }
  }



  void checkIfStared(String listingId) {
    if (userStore.isLogin) {
      isStared.value = userStore.customerProfilesDetails['starredListIds'].contains(listingId);
    } else {
      isStared.value = false;
    }
  }

  // 处理下拉刷新逻辑的方法
  Future<void> refreshUI() async {
    loadData();
  }

  Future<void> loadData() async {
    currentPage.value = 0;
    await fetchPostedListings(currentPage.value);
    state.staredLists.assignAll(userStore.customerProfilesDetails['starredListIds'] ?? []);
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      currentPage.value++;
      fetchPostedListings(currentPage.value);
    }
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    loadData();
    super.onInit();
  }

  // bool isStared(String postID) {
  //   //登录之后根据用户数据进行查询
  //   return userStore.customerProfilesDetails['starredListIds'].contains(postID);
  // }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    scrollController.dispose(); // Always dispose controllers
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }
}