import 'package:get/get.dart';

class EditPostState {
  final _images = <dynamic>[].obs;
  set images(value) => _images.value = value;
  get images => _images;

  final _category = "".obs;
  set category(value) => _category.value = value;
  get category => _category.value;

  final Rx<Map<String, dynamic>> _editPost = Rx<Map<String, dynamic>>({});
  set editPost(Map<String, dynamic> value) => _editPost.value = value;
  Map<String, dynamic> get editPost => _editPost.value;

}
