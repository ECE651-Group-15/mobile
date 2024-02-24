import 'package:get/get.dart';

class MyPostPostState {
  // title
  // final _title = "".obs;
  // set title(value) => _title.value = value;
  // get title => _title.value;
   final  _customerId=''.obs;
   set customerId(value) => _customerId.value = value;
   get customerId => _customerId.value;

   final RxList<dynamic> _postedListings = <dynamic>[].obs;
   set postedListings(List<dynamic> value) => _postedListings.value = value;
   List<dynamic> get postedListings => _postedListings;
}