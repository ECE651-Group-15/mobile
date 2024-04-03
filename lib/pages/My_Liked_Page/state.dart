import 'package:get/get.dart';

class MyLikedPostPostState {

  final RxList<dynamic> _postedListings = <dynamic>[].obs;
  set postedListings(List<dynamic> value) => _postedListings.value = value;
  List<dynamic> get postedListings => _postedListings;

}