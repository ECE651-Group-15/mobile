import 'dart:convert';

import 'package:exchange/common/store/store.dart';
import 'package:exchange/pages/completed_order_page/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../../common/apis/post.dart'; // Adjust import based on your project structure
import '../../common/entities/post.dart';
import '../../common/values/server.dart'; // Adjust import based on your project structure

class CompletedOrderController extends GetxController {
  final state = CompletedOrderState();
  UserStore userStore = Get.find<UserStore>();

  Future<void> markAsAvailable (var item) async {
    MarkAsSoldRequestEntity req = MarkAsSoldRequestEntity(
        id: item['id'],
        title: item['title'],
        description: item['description'],
        price: item['price'],
        longitude: item['longitude'],
        latitude: item['latitude'],
        category: item['category'],
        customerId:item['customerId'],
        status: "ACTIVE",
        images: item['images']?.cast<String>()
    );

    try {
      MarkAsSoldResponseEntity res = await PostApi.markAsSold(req);
      if (res.code == 200) {
        EasyLoading.showSuccess('mark post success');
        getCompletedOrder();
      } else {
        EasyLoading.showError('mark post failed, try later');
      }
    } catch (e) {
      EasyLoading.showError('mark post failed, try later');
    }
  }

  Future<void> getCompletedOrder()async {
    GetCompletedOrderRequestEntity req = GetCompletedOrderRequestEntity(
       page: 0,
       customerId: userStore.customerProfilesDetails['id']
    );

    try {
      GetCompletedOrderResponseEntity res = await PostApi.getCompletedOrder(req);
      if (res.code == 200) {
        state.listings.value = res.data!.completedListings!;
      } else {
        EasyLoading.showError('mark post failed, try later');
      }
    } catch (e) {
      EasyLoading.showError('mark post failed, try later');
    }

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
        userProfile = {};
      }
    } catch (e) {
      userProfile = {}; // 捕获异常时也确保返回一个空Map
    }
    return userProfile;
  }
  // Future<bool> deleteListing(String listingId) async {
  //   var url = '${APIConstants.deleteListing}/$listingId';
  //   var request = http.Request('POST', Uri.parse(url));
  //
  //   try {
  //     http.StreamedResponse response = await request.send();
  //     String responseBody = await response.stream.bytesToString();
  //     var decodedResponse = json.decode(responseBody);
  //     if (decodedResponse['code'] == 200) {
  //       EasyLoading.showSuccess('delete post success');
  //       homeController.loadData();
  //       refreshUI();
  //       return true; // 返回 true 表示删除成功
  //     } else {
  //       return false; // 返回 false 表示删除失败
  //     }
  //   } catch (e) {
  //     return false; // 捕获异常，返回 false
  //   }
  // }

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
                  // deleteListing(postID);
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

  /// 在 widget 内存中分配后立即调用。
  @override
  Future<void> onInit() async {
    super.onInit();
    getCompletedOrder();
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
