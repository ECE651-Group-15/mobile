import 'package:get/get.dart';

class LoginControllerState {
  // title

  var userId = ''.obs; // 使用 .obs 将其标记为可观察的

  final _isLogin = false.obs;
  set isLogin(value) => _isLogin.value = value;
  get isLogin => _isLogin.value;

  final customerProfilesDetails = <String, dynamic>{}.obs;

  final RxString _id = ''.obs;
  final RxString _name = ''.obs;
  final RxString _email = ''.obs;
  final RxString _avatar = ''.obs;
  final RxString _phone = ''.obs;
  final RxDouble _longitude = RxDouble(0.0);
  final RxDouble _latitude = RxDouble(0.0);
  final RxList<String> _postedListingIds = <String>[].obs;
  final RxList<String> _starredListIds = <String>[].obs;

  // Getters and setters for each property
  String get id => _id.value;
  set id(String value) => _id.value = value;

  String get name => _name.value;
  set name(String value) => _name.value = value;

  String get email => _email.value;
  set email(String value) => _email.value = value;

  String get avatar => _avatar.value;
  set avatar(String value) => _avatar.value = value;

  String get phone => _phone.value;
  set phone(String value) => _phone.value = value;

  double? get longitude => _longitude?.value;
  set longitude(double? value) => _longitude?.value = value ?? 0.0;

  double? get latitude => _latitude?.value;
  set latitude(double? value) => _latitude?.value = value ?? 0.0;

  List<String> get postedListingIds => _postedListingIds.toList();
  set postedListingIds(List<String> value) => _postedListingIds.assignAll(value);

  List<String> get starredListIds => _starredListIds.toList();
  set starredListIds(List<String> value) => _starredListIds.assignAll(value);

}