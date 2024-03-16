import 'package:exchange/common/apis/post.dart';
import 'package:exchange/common/entities/post.dart';
import 'package:exchange/common/values/server.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../common/store/user.dart';
import 'index.dart';
import 'dart:convert';

class HomeController extends GetxController {
  UserStore userStore = Get.find<UserStore>();

  HomeController();
 // 获取控制器实例
  final state = HomeState();

  Future<List<dynamic>> fetchCustomerPostedListings(int n) async {
    var request = http.Request(
        'POST', Uri.parse(APIConstants.fetchCustomerPostedListingsUrl));
    request.body = json.encode({"page": n});
    // 初始化postedListings为空列表
    List<dynamic> postedListings = [];
    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseBody);
      if (decodedResponse['code'] == 200) {
        postedListings = decodedResponse['data']['listingDetails'];
      } else {
        print(response.reasonPhrase);
        // 可选: 抛出异常或返回错误信息
      }
    } catch (e) {
      // 异常处理
      print('An error occurred: $e');
      // 可选: 抛出异常或返回错误信息
    }
    return postedListings;
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
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json'
    };

    var request = http.Request('POST', Uri.parse(APIConstants.starListingUrl));
    request.body =
        json.encode({"customerId": userStore.customerProfilesDetails['id'], "listingId": listingId});
    request.headers.addAll(headers);

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
    loadData(0);
  }

  void loadData(int n) async {
    var userId = userStore.customerProfilesDetails['id'];
    if (userId != null) {
      var userStaredLists = await fetchUserStaredLists(userId);
      state.staredLists.assignAll(userStaredLists);// 其他逻辑
    } else {
      // 处理 userId 为 null 的情况
    }
     var postedListings = await fetchCustomerPostedListings(n); // Await the future
    state.listings.assignAll(postedListings); // Assign the awaited data
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

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    loadData(0);
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
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }
}
