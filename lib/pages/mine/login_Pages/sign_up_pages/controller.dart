import 'dart:convert';
import 'package:exchange/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'index.dart';

class EmailCheckResult {
  final bool isAvailable;
  final String? errorMessage;

  EmailCheckResult({required this.isAvailable, this.errorMessage});
}

class SignUpController extends GetxController {
  SignUpController();

  final state = SignUpControllerState();

  Future<bool> registerUser() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://ec2-18-223-182-150.us-east-2.compute.amazonaws.com:8080/v1/api/profile/create-profile'));
    request.body = json.encode({
      "email": state.email,
      "name": state.name,
      "password": state.pwd,
      "phone": ""
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseBody);
      if (decodedResponse['code'] == 200) {
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
      // 可能需要处理异常
    }
  }

  bool isValidEmail(String email) {
    // 使用正则表达式来验证电子邮件地址的有效性
    return RegExp(r'^\S+@\S+\.\S+$').hasMatch(email);
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('registration success'),
          content: const Text(
              'Congratulations, you have successfully registered as a user'),
          actions: <Widget>[
            TextButton(
              child: const Text('Return to login interface'),
              onPressed: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoutes.application);
              },
            ),
          ],
        );
      },
    );
  }

  Future<EmailCheckResult> checkEmailAvailable(String email) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://ec2-18-223-182-150.us-east-2.compute.amazonaws.com:8080/v1/api/profile/check-email'));
    request.body = json.encode({"email": email});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      // 如果状态码为200，解析响应体判断电子邮箱是否已被使用
      var decodedResponse = json.decode(responseBody);
      if (decodedResponse['code'] == 4001) {
        // 假设代码 4001 表示电子邮件已存在
        return EmailCheckResult(
            isAvailable: false, errorMessage: decodedResponse['message']);
      } else {
        return EmailCheckResult(isAvailable: true);
      }
    } catch (e) {
      // 捕获请求过程中的异常
      print(e.toString());
      return EmailCheckResult(
          isAvailable: true,
          errorMessage:
              'Failed to check email availability. Please try again later.');
    }
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
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
