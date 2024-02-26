import 'dart:convert';
import 'package:exchange/common/values/server.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'index.dart';

class MyLikedPostController extends GetxController {
  MyLikedPostController();

  final state = MyLikedPostPostState();

  Future<List<dynamic>> fetchStarredListings(
      String customerId, int page, int pageSize) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json'
    };

    var request = http.Request('POST', Uri.parse(APIConstants.starredListing));
    request.body = json
        .encode({"customerId": customerId, "page": page, "pageSize": pageSize});
    request.headers.addAll(headers);
    List<dynamic> postedListings = [];
    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> parsedJson = jsonDecode(responseBody);
      if (parsedJson['code'] == 200) {
        // 这里可以根据需要进一步处理响应体
        postedListings = parsedJson['data']['starredListings'];
      } else {
        print("Failed to fetch starred listings: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception caught: $e");
      // 这里可以处理异常情况
    }
    return postedListings;
  }

  Future<void> loadData() async {
    state.customerId = "b16f6fd7-fbe1-4665-8d03-ea8ec63ef78b";
    state.postedListings = await fetchStarredListings(
        state.customerId, 0, 6); //id,page,page size  返回第几页数据,一页四个帖子内容
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
