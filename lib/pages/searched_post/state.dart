import 'package:exchange/common/entities/post.dart';
import 'package:get/get.dart';

class SearchMainState {
  final RxString _title = "".obs;
  set title(String value) => _title.value = value;
  String get title => _title.value;

  final RxList<Data> listings = <Data>[].obs;
  //final RxMap<String, bool> favorites = <String, bool>{}.obs; // Use RxMap for observable map

  // final RxString userID = ''.obs; // No need for late keyword
  final RxList<dynamic> staredLists =
      <dynamic>[].obs; // No need for late keyword
  //
  // final _userId = "".obs;
  // set userId(value) => _userId.value = value;
  // get userId => _userId.value;

  final customerProfilesDetails = <String, dynamic>{}.obs;
}
