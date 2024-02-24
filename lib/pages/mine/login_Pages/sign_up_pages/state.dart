import 'package:get/get.dart';

class SignUpControllerState {
  final RxString _email = "".obs;
  set email(String value) => _email.value = value;
  String get email => _email.value;

  final RxString _name = "".obs;
  set name(String value) => _name.value = value;
  String get name => _name.value;

  final RxString _pwd = "".obs;
  set pwd(String value) => _pwd.value = value;
  String get pwd => _pwd.value;
}
