import 'package:get/get.dart';

class CreatePostState {
  // title
  final _title = "".obs;
  set title(value) => _title.value = value;
  get title => _title.value;

  final _images = <String>[].obs;
  set images(value) => _images.value = value;
  get images => _images;
}
