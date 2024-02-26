import 'package:get/get.dart';

import '../home/controller.dart';

class MyProfileControllerState {
  // title
  final _title = "".obs;
  set title(value) => _title.value = value;
  get title => _title.value;


  final _customerProfilesDetails = <String, dynamic>{}.obs;
  set customerProfilesDetails(Map<String, dynamic> value) => _customerProfilesDetails.value = value;
  Map<String, dynamic> get customerProfilesDetails => _customerProfilesDetails;
}