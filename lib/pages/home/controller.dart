import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'index.dart';
import 'dart:convert';
class HomeController extends GetxController {
  HomeController();

  final state = HomeState();
  // tap
  void handleTap(int index) {
    Get.snackbar(
      "标题",
      "消息",
    );
  }
  Future<List<dynamic>> fetchCustomerPostedListings() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://ec2-3-145-145-71.us-east-2.compute.amazonaws.com:8080/v1/api/listing-profile/get-listing-page'));
    request.body = json.encode({
      "page": 0
    });
    request.headers.addAll(headers);
    // 初始化postedListings为空列表
    List<dynamic> postedListings = [];
    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseBody);

      if (decodedResponse['code'] == 200) {
        print(responseBody);
        postedListings = decodedResponse['data']['listingDetails'];
      } else {
        print(response.reasonPhrase);
        // 可选: 抛出异常或返回错误信息
      }
    }catch (e) {
      // 异常处理
      print('An error occurred: $e');
      // 可选: 抛出异常或返回错误信息
    }
    return postedListings;
  }
  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
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
  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
    fetchCustomerPostedListings().then((data) {
      state.listings.assignAll(data); // 更新列表数据
    });
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
