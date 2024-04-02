import 'package:get/get.dart';

class ImagePostState {

  // 不再使用 late final，而是直接声明 Rx<Map<String, dynamic>>
  late final Rx<Map<String, dynamic>> detailedPost =
      Rx<Map<String, dynamic>>({});
  final _listingId = "".obs;
  set listingId(value) => _listingId.value = value;
  get listingId => _listingId.value;
  var isStared = false.obs;

}
