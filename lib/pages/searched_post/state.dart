import 'package:exchange/common/entities/post.dart';
import 'package:get/get.dart';

class SearchMainState {
  final RxString _title = "".obs;
  set title(String value) => _title.value = value;
  String get title => _title.value;

  final RxList<Data> listings = <Data>[].obs;
  //final RxMap<String, bool> favorites = <String, bool>{}.obs; // Use RxMap for observable map

  final RxList<dynamic> _postedListings = <dynamic>[].obs;
  set postedListings(List<dynamic> value) => _postedListings.value = value;
  List<dynamic> get postedListings => _postedListings;

  // final RxString userID = ''.obs; // No need for late keyword
  final RxList<dynamic> staredLists = <dynamic>[].obs; // No need for late keyword

  final customerProfilesDetails = <String, dynamic>{}.obs;
}
