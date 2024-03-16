import 'dart:convert';
import 'package:exchange/common/values/server.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:exchange/pages/my_post/state.dart';
import 'package:get/get.dart';
import '../../common/apis/post.dart';
import '../../common/entities/post.dart';
import '../../common/store/user.dart';
import '../home/controller.dart';
import 'index.dart';


class MyPostController extends GetxController {

  final state = MyPostPostState();
  UserStore userStore = Get.find<UserStore>();
  final HomeController homeController = Get.find<HomeController>();
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

  Future<bool> deleteListing(String listingId) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json', // 如果你的API需要
    };

    var url = '${APIConstants.deleteListing}/$listingId';
    var request = http.Request('POST', Uri.parse(url));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseBody);
      if (decodedResponse['code'] == 200) {
        EasyLoading.showSuccess('delete post success');
        homeController.loadData(0);
        refreshUI();
        return true; // 返回 true 表示删除成功
      } else {
        print(response.reasonPhrase);
        return false; // 返回 false 表示删除失败
      }
    } catch (e) {
      print(e.toString());
      return false; // 捕获异常，返回 false
    }
  }

  void showDeleteConfirmationDialog(BuildContext context, String postID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text('Delete this listing?'),
          content: const Text('Are you sure you delete this listing?'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: TextButton(
                child: const Text('Yes, delete',
                    style: TextStyle(color: Colors.green)),
                onPressed: () {
                  deleteListing(postID);
                  Get.back();// Close the dialog
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
               Get.back();// Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                    0xFF00008B), // Use backgroundColor instead of primary
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, dynamic>?> getProfile(String userId) async {
    GetProfileRequestEntity req = GetProfileRequestEntity(
      customerId: userId,
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

  Future<void> loadData() async {
    state.customerId = userStore.customerProfilesDetails['id']??'';
    state.postedListings =
        await fetchCustomerPostedListings(state.customerId, 0);
  }

  Future<void> refreshUI() async {
    loadData();
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  Future<void> onInit() async {
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
