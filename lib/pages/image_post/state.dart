import 'package:get/get.dart';

class ImagePostState {
  // title
  final _title = "".obs;
  set title(value) => _title.value = value;
  get title => _title.value;

  // 不再使用 late final，而是直接声明 Rx<Map<String, dynamic>>
  late final Rx<Map<String, dynamic>> detailedPost = Rx<Map<String, dynamic>>({});

  final _customerProfilesDetails = <String, dynamic>{}.obs;
  set customerProfilesDetails(Map<String, dynamic> value) => _customerProfilesDetails.value = value;
  Map<String, dynamic> get customerProfilesDetails => _customerProfilesDetails;
}
