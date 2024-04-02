import 'package:get/get.dart';

class MyLikedPostPostState {

  final RxList<dynamic> _postedListings = <dynamic>[].obs;
  set postedListings(List<dynamic> value) => _postedListings.value = value;
  List<dynamic> get postedListings => _postedListings;

  final _customerProfilesDetails = <String, dynamic>{}.obs;
  set customerProfilesDetails(Map<String, dynamic> value) => _customerProfilesDetails.value = value;
  Map<String, dynamic> get customerProfilesDetails => _customerProfilesDetails;
}