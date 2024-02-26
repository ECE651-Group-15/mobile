import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:exchange/common/values/server.dart';

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

void showOptions(BuildContext context, String listingId) {
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
              Navigator.pop(context); // 关闭底部弹窗
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('delete'),
            onTap: () {
              deleteListing(listingId); // 实现删除功能的代码
              Navigator.pop(context); // 关闭底部弹窗
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

  var url = '${APIConstants.deleteListing}/$listingId';
  var request = http.Request('POST', Uri.parse(url));

  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseBody);
    if (decodedResponse['code'] == 200) {
      // print(responseBody);
      // print(await response.stream.bytesToString());
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
