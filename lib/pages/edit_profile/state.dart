import 'package:get/get.dart';

class EditProfileControllerState {
  final RxString _email = "".obs;
  set email(String value) => _email.value = value;
  String get email => _email.value;

  final RxString _name = "".obs;
  set name(String value) => _name.value = value;
  String get name => _name.value;

  final RxString _phone = "".obs;
  set phone(String value) => _phone.value = value;
  String get phone => _phone.value;

  // Added for avatar
  final RxString _avatar = "".obs;
  set avatar(String value) => _avatar.value = value;
  String get avatar => _avatar.value;
}
