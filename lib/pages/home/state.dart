import 'package:get/get.dart';

import '../../common/entities/post.dart';

class HomeState {
  final RxString _title = "".obs;
  set title(String value) => _title.value = value;
  String get title => _title.value;

  final RxList <ListingDetails> listings = <ListingDetails>[].obs;
  final RxMap<String, bool> favorites = <String, bool>{}.obs; // Use RxMap for observable map

  // final RxString userID = ''.obs; // No need for late keyword
  final RxList<dynamic> staredLists = <dynamic>[].obs; // No need for late keyword

  final customerProfilesDetails = <String, dynamic>{}.obs;
}
