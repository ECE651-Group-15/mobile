import 'dart:typed_data';
import 'package:exchange/common/apis/post.dart';
import 'package:exchange/common/entities/post.dart';
import 'package:exchange/common/routes/names.dart';
import 'package:exchange/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../home/controller.dart';
import '../login_Pages/controller.dart';
import '../my_post/controller.dart';
import 'index.dart';

class EditPostController extends GetxController {
  EditPostController();

  LoginController loginController = Get.find<LoginController>();
  final state = EditPostState();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void uploadImage(XFile? file) async {
    if (file == null) {
      EasyLoading.showInfo("No image selected");
      return;
    }
    EasyLoading.show(
      status: 'uploading...',
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );
    try {
      Uint8List fileBytes = await file.readAsBytes();
      await client.putObject(
        fileBytes,
        file.name,
      );
      state.images.add(file.name); // store image name in state array
      EasyLoading.showSuccess('upload image success');
    } catch (e) {
      EasyLoading.showError('upload image failed, try later');
    }
  }

  void editPost(BuildContext context) async {
    if (state.images.isEmpty) {
      EasyLoading.showInfo("Please select at least one image");
      return;
    }
    if (titleController.text.isEmpty) {
      EasyLoading.showInfo("Please input title");
      return;
    }
    if (descriptionController.text.isEmpty) {
      EasyLoading.showInfo("Please input description");
      return;
    }
    if (priceController.text.isEmpty) {
      EasyLoading.showInfo("Please input price");
      return;
    }
    if (state.category.isEmpty) {
      EasyLoading.showInfo("Please select category");
      return;
    }

    EditPostRequestEntity req = EditPostRequestEntity(
      id: state.editPost['id'],
      title: titleController.text,
      description: descriptionController.text,
      price: double.parse(priceController.text),
      longitude: 0,
      latitude: 0,
      category: state.category,
      customerId:
      loginController.state.userId.value, // TODO: change to real logged user id
      status: "ACTIVE",
      images: state.images.value.cast<String>(), // 使用.cast<String>()确保类型正确
    );

    EasyLoading.show(
      status: 'creating...',
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );
    try {
      EditPostResponseEntity res = await PostApi.editPost(req);
      if (res.code == 200) {
        EasyLoading.showSuccess('edit post success');
        Get.find<MyPostController>().refreshUI(); // 刷新帖子列表
        Get.find<HomeController>().refreshUI();
        Get.back(); // 使用Get.back()来返回上一页 // Close the dialog
      } else {
        EasyLoading.showError('edit post failed, try later');
      }
      print(res.toJson());
      // TODO: navigate to post detail page
    } catch (e) {
      EasyLoading.showError('edit post failed, try later');
    }
  }

  Future<void> loadData() async {
    final Map<String, dynamic>  editPost = Get.arguments ??{};

    if(editPost.isNotEmpty) {
      state.editPost = editPost;
      state.images = (editPost['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
      titleController.text = editPost['title'] ?? '';
      descriptionController.text = editPost['description'] ?? '';
      priceController.text = editPost['price']?.toString() ?? '';
      state.category = editPost['category'] ?? '';
    }

  }

  void refreshUI() {
    loadData();
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }
}

void showSuccessPost(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Create post successfully'),
        content:
            const Text('Congratulations, you have successfully create a post'),
        actions: <Widget>[
          TextButton(
            child: const Text('Return to my post page'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MinePage()),
              // );
              /// Navigator.pushReplacement(
              ///   context,
              ///   MaterialPageRoute(builder: (context) => MyPostPage()),
              //  ); //
              Get.toNamed(AppRoutes.application);

// 关闭对话框
            },
          ),
        ],
      );
    },
  );
}
