import 'package:get/get.dart';

class MineState {
  // title
  final _title = "".obs;
  set title(value) => _title.value = value;
  get title => _title.value;

  final _userId = "".obs;
  set userId(value) => _userId.value = value;
  get userId => _userId.value;

  final customerProfilesDetails = <String, dynamic>{}.obs;
}
