import 'package:exchange/common/apis/post.dart';
import 'package:exchange/common/entities/post.dart';
import 'package:exchange/common/values/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../common/store/user.dart';
import 'index.dart';
import 'dart:convert';

class HomeController extends GetxController {
  UserStore userStore = Get.find<UserStore>();
  var scrollController = ScrollController();
  var currentPage = 0.obs;
  HomeController();
  final state = HomeState();

  Future<void> fetchPostedListings(int n) async {
    FetchPostedListingsRequestEntity req = FetchPostedListingsRequestEntity(
      page: n,
    );
    try {
      FetchPostedListingsResponseEntity response = await PostApi.fetchListings(req);
      if (response.code == 200 && response.data != null && response.data!.listingDetails != null) {
        // 当n不等于0时，将新的列表项添加到现有的列表中
        if (n != 0) {
          state.listings.addAll(response.data!.listingDetails!);
        } else {
          // 当n等于0时，先清空列表，再添加新的列表项
          state.listings.clear();
          state.listings.addAll(response.data!.listingDetails!);
        }
        EasyLoading.dismiss();
      } else {
        EasyLoading.showError('Failed to fetch listings');
      }
    } catch (e) {
      print(e);
      EasyLoading.showError('Error: $e');
    }
  }



  Future<List<dynamic>> fetchUserStaredLists(String userId) async {
    var url = '${APIConstants.fetchUserStarredListsUrl}/$userId';
    var request = http.Request('POST', Uri.parse(url));
    List<dynamic> staredListings = [];
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    try {
      var decodedResponse = json.decode(responseBody);
      if (decodedResponse['code'] == 200) {

        if (decodedResponse['data']['starredListIds'] != null) {
          staredListings.assignAll(decodedResponse['data']['starredListIds']);
        }
        state.customerProfilesDetails.assignAll(decodedResponse['data']);
        // print(responseBody);
      } else {
        print('Failed to load user profile: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
    return staredListings;
  }

  Future<void> starListing(String listingId) async {
    var request = http.Request('POST', Uri.parse(APIConstants.starListingUrl));
    request.body =
        json.encode({"customerId": userStore.customerProfilesDetails['id'], "listingId": listingId});

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseBody);

      if (decodedResponse['code'] == 200) {
        print("Success: ${await response.stream.bytesToString()}");
      } else {
        print("Error: ${response.reasonPhrase ?? 'Unknown Error'}");
      }
    } catch (e) {
      print("Exception occurred: $e");
    }
  }

  // 处理下拉刷新逻辑的方法
  Future<void> refreshUI() async {
    loadData();
  }

  void loadData() async {
    var userId = userStore.customerProfilesDetails['id'];
    if (userId != null) {
      var userStaredLists = await fetchUserStaredLists(userId);
      state.staredLists.assignAll(userStaredLists);// 其他逻辑
    } else {
      // 处理 userId 为 null 的情况
    }
    currentPage.value=0;
    fetchPostedListings(currentPage.value);
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
      } else {
        EasyLoading.showError('unstar post failed, try later');
      }
      // print(res.toJson());
    } catch (e) {
      print(e.toString()); // 打印异常信息
      EasyLoading.showError('unstar post failed, try later');
    }
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
    super.onInit();
    // loadData();
    scrollController.addListener(_scrollListener);
    fetchPostedListings(currentPage.value);
  }

  bool isStared(String postID) {
    //登录之后根据用户数据进行查询
    if (state.staredLists.contains(postID)) {
      return true;
    } else {
      return false;
    }
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }
}