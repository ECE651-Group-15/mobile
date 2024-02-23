import 'package:get/get.dart';

class HomeState {
  // title
  final _title = "".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
  final RxList<dynamic> listings = <dynamic>[].obs;
  final favorites = <String, bool>{}.obs; // 新增，用于跟踪收藏状态

}
