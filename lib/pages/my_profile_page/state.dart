import 'package:get/get.dart';


class MyProfileControllerState {
  final _customerProfilesDetails = <String, dynamic>{}.obs;
  set customerProfilesDetails(Map<String, dynamic> value) => _customerProfilesDetails.value = value;
  Map<String, dynamic> get customerProfilesDetails => _customerProfilesDetails;
}