import 'dart:convert';
import 'package:exchange/common/apis/post.dart';
import 'package:exchange/common/entities/post.dart';
import 'package:exchange/common/values/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    var request =
        http.Request('POST', Uri.parse(APIConstants.createProfileUrl));
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

  Future<bool> checkEmailAvailable(String email) async {
    CheckEmailRequestEntity req = CheckEmailRequestEntity(
      email: email,
    );
    try{
      CheckEmailResponseEntity res = await PostApi.checkEmail(req);
      if(res.code==200){
        return false;
      }
      else{
        return true;
      }
    }
    catch(e){
      EasyLoading.showError('create post failed: $e');
      print('Error : $e');
      return false;
    }
    // var request = http.Request('POST', Uri.parse(APIConstants.checkEmail));
    // request.body = json.encode({"email": email});
    // http.StreamedResponse response = await request.send();
    // String responseBody = await response.stream.bytesToString();
    // var decodedResponse = json.decode(responseBody);
    // if (decodedResponse['code'] == 200) {
    //   return false;
    // } else {
    //   return true;
    // }
  }


  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('registration success'),
          actions: <Widget>[
            TextButton(
              child: const Text('Return to login page'),
              onPressed: () {
                Get.close(4);
              },
            ),
          ],
        );
      },
    );
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
