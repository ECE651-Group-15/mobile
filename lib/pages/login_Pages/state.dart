import 'package:get/get.dart';

class LoginControllerState {
  // title

  var userId = ''.obs; // 使用 .obs 将其标记为可观察的

  final _isLogin = false.obs;
  set isLogin(value) => _isLogin.value = value;
  get isLogin => _isLogin.value;

  final customerProfilesDetails = <String, dynamic>{}.obs;
}