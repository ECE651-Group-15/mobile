import 'package:exchange/common/services/services.dart';
import 'package:exchange/common/values/values.dart';
import 'package:get/get.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;
  // 令牌 token
  String token = '';
  // 用户 profile
  // final _profile = User().obs;

  bool get isLogin => _isLogin.value;
  // User get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(storageUserTokenKey);
    if (token.isNotEmpty) {
      _isLogin.value = true;
    }
    var profileOffline = StorageService.to.getString(storageUserProfileKey);
    if (profileOffline.isNotEmpty) {
      // _profile(UserLoginResponseEntity.fromJson(jsonDecode(profileOffline)));
    }
  }

  // 保存 token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(storageUserTokenKey, value);
    token = value;
  }

  // 获取 profile
  Future<void> getProfile() async {
    if (token.isEmpty) return;
    // var result = await UserAPI.profile();
    // _profile(result);
    // _isLogin.value = true;
    // StorageService.to.setString(storageUserTokenKey, jsonEncode(result));
  }

  // 保存 profile
  // Future<void> saveProfile(User profile) async {
  //   _isLogin.value = true;
  //   StorageService.to.setString(storageUserTokenKey, profile.token);
  //   StorageService.to.setString(storageUserProfileKey, jsonEncode(profile));
  // }

  // 注销
  Future<void> onLogout() async {
    // if (_isLogin.value) await User.logout();
    await StorageService.to.remove(storageUserTokenKey);
    _isLogin.value = false;
    token = '';
  }
}
