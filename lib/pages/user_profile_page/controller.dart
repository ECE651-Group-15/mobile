import 'dart:convert';
import 'package:exchange/common/values/server.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'index.dart';

class UserProfileController extends GetxController{
  UserProfileController();

  final state = UserProfileControllerState();

  Future<List<dynamic>> fetchCustomerPostedListings(
      String customerId, int page) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json'
    };

    var request =
    http.Request('POST', Uri.parse(APIConstants.customerPostedListings));

    request.body = json.encode({"page": page, "customerId": customerId});

    request.headers.addAll(headers);

    // 初始化postedListings为空列表
    List<dynamic> postedListings = [];
    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseBody);

      if (decodedResponse['code'] == 200) {
        // print(responseBody);
        postedListings = decodedResponse['data']['postedListings'];
        // state.postedListings=postedListings;
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

  Future<void> loadData() async {
    state.customerId = "b16f6fd7-fbe1-4665-8d03-ea8ec63ef78b";
    state.postedListings =
    await fetchCustomerPostedListings(state.customerId, 0);
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