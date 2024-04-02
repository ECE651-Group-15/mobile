import 'package:get/get.dart';

import '../../common/entities/post.dart';

class HomeState {

  final RxList <ListingDetails> listings = <ListingDetails>[].obs;

  final RxList<dynamic> staredLists = <dynamic>[].obs; // No need for late keyword
}
