import 'package:get/get.dart';

class HomeState {
  final RxString _title = "".obs;
  set title(String value) => _title.value = value;
  String get title => _title.value;

  final RxList<dynamic> listings = <dynamic>[].obs;
  final RxMap<String, bool> favorites = <String, bool>{}.obs; // Use RxMap for observable map

  final RxString userID = ''.obs; // No need for late keyword
  final RxList<dynamic> staredLists = <dynamic>[].obs; // No need for late keyword

  final _userId = "".obs;
  set userId(value) => _userId.value = value;
  get userId => _userId.value;

  final customerProfilesDetails = <String, dynamic>{}.obs;
}
