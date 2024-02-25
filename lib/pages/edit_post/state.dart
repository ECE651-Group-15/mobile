import 'package:get/get.dart';

class EditPostState {
  final _images = <String>[].obs;
  set images(value) => _images.value = value;
  get images => _images;

  final _category = "".obs;
  set category(value) => _category.value = value;
  get category => _category.value;

  final _id = ''.obs;
  set id(value) => _id.value = value;
  get id => _id;
}
