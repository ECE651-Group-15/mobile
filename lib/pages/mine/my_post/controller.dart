import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:exchange/pages/mine/my_post/state.dart';
import 'package:get/get.dart';
import 'index.dart';


class MyPostController extends GetxController{

  MyPostController();
  final state = MyPostPostState();

  Future<List<dynamic>> fetchCustomerPostedListings(String customerId, int page) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json'
    };

    var request = http.Request(
        'POST',
        Uri.parse(
            'http://ec2-3-145-145-71.us-east-2.compute.amazonaws.com:8080/v1/api/listing-profile/get-customer-posted-listings'));

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

  void showOptions(BuildContext context,String listingId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min, // 使内容尽可能紧凑
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('edit'),
              onTap: () {
                // 实现编辑功能的代码
                Navigator.pop(context);// 关闭底部弹窗

              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('delete'),
              onTap: () {
                deleteListing(listingId);// 实现删除功能的代码
                Navigator.pop(context);// 关闭底部弹窗
              },
            ),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('maked as sold'),
              onTap: () {
                // 实现分享功能的代码
                Navigator.pop(context); // 关闭底部弹窗
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> deleteListing(String listingId) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json', // 如果你的API需要
    };

    var url = 'http://ec2-3-145-145-71.us-east-2.compute.amazonaws.com:8080/v1/api/listings/delete-listing/$listingId';
    var request = http.Request('POST', Uri.parse(url));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseBody);
      if (decodedResponse['code'] == 200) {
        // print(responseBody);
        EasyLoading.showSuccess('delete post success');
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text('Delete this listing?'),
          content: const Text('Are you sure you delete this listing?'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: TextButton(
                child: const Text('Yes, delete', style: TextStyle(color: Colors.green)),
                onPressed: () {
                  deleteListing(postID);
                  refreshUI();
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00008B), // Use backgroundColor instead of primary
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



  Future<void> loadData() async {
    state.customerId=   "b16f6fd7-fbe1-4665-8d03-ea8ec63ef78b" ;
    state.postedListings = await fetchCustomerPostedListings(state.customerId, 0) ;
  }

  void refreshUI() {
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
