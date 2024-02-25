import 'package:exchange/common/values/server.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'index.dart';
import 'dart:convert';

class HomeController extends GetxController {
  HomeController();

  final state = HomeState();
  // tap
  // void handleTap(int index) {
  //   Get.snackbar(
  //     "var      "消息",
  //   );
  // }
  Future<List<dynamic>> fetchCustomerPostedListings() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse(APIConstants.fetchCustomerPostedListingsUrl));
    request.body = json.encode({"page": 0});
    request.headers.addAll(headers);
    // 初始化postedListings为空列表
    List<dynamic> postedListings = [];
    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseBody);

      if (decodedResponse['code'] == 200) {
        // print(responseBody);
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
    var headers = {'User-Agent': 'Apifox/1.0.0 (https://apifox.com)'};
    var url = '${APIConstants.fetchUserStarredListsUrl}/$userId';
    var request = http.Request('POST', Uri.parse(url));

    request.headers.addAll(headers);
    List<dynamic> staredListings = [];

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseBody);

      if (decodedResponse['code'] == 200) {
        if (decodedResponse['data']['starredListIds'] != null) {
          staredListings.assignAll(decodedResponse['data']['starredListIds']);
        }
        print(responseBody);
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
        json.encode({"customerId": state.userID.value, "listingId": listingId});
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

  void loadData() async {
    state.userID.value =
        'b16f6fd7-fbe1-4665-8d03-ea8ec63ef78b'; // Assign to `value`
    var userStaredLists =
        await fetchUserStaredLists(state.userID.value); // Await the future
    state.staredLists.assignAll(userStaredLists); // Assign the awaited data

    var postedListings =
        await fetchCustomerPostedListings(); // Await the future
    state.listings.assignAll(postedListings); // Assign the awaited data
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

  // 新增方法，处理收藏/取消收藏操作
  void toggleFavorite(String listingId) {
    if (state.favorites[listingId] == true) {
      state.favorites[listingId] = false;
    } else {
      state.favorites[listingId] = true;
    }
    state.favorites.refresh();
    update(); // 可以调用 update() 以触发使用 GetX 的 widget 重建。// 通知监听者更新
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
