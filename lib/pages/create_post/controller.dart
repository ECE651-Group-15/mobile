import 'package:get/get.dart';

import 'index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostController extends GetxController {
  CreatePostController();

  final state = CreatePostState();

  Future<void> saveDraft(
      String title, String description, String category, String price) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('draftTitle', title);
    await prefs.setString('draftDescription', description);
    await prefs.setString('draftCategory', category);
    await prefs.setString('draftPrice', price);
  }

  Future<Map<String, String>> loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    final title = prefs.getString('draftTitle') ?? '';
    final description = prefs.getString('draftDescription') ?? '';
    final category = prefs.getString('draftCategory') ?? '';
    final price = prefs.getString('draftPrice') ?? '';
    return {
      'title': title,
      'description': description,
      'category': category,
      'price': price,
    };
  }

  // tap
  void handleTap(int index) {
    Get.snackbar(
      "标题",
      "消息",
    );
  }

  void handleUploadImage() {
    // client.putObject
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();

    // request backend authorizagion service
    // get accessKey .....
    // Client initializae
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }
}
