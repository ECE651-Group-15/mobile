import 'dart:typed_data';
import 'package:exchange/common/apis/post.dart';
import 'package:exchange/common/entities/post.dart';
import 'package:exchange/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../login_Pages/controller.dart';
import 'index.dart';

class CreatePostController extends GetxController {
  CreatePostController();

  final state = CreatePostState();
  LoginController loginController = Get.find<LoginController>();
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

  void createPost(BuildContext context) async {
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

    CreatePostRequestEntity req = CreatePostRequestEntity(
      title: titleController.text,
      description: descriptionController.text,
      price: double.parse(priceController.text),
      images: state.images,
      longitude: 0,
      latitude: 0,
      category: state.category,
      customerId:
          loginController.state.userId.value, // TODO: change to real logged user id
      status: "ACTIVE",
    );

    EasyLoading.show(
      status: 'creating...',
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );
    try {
      CreatePostResponseEntity res = await PostApi.createPost(req);
      if (res.code == 200) {
        EasyLoading.dismiss();
        //EasyLoading.showSuccess('create post success');
        showSuccessPost(context);
      } else {
        EasyLoading.showError('create post failed, try later');
      }
      print(res.toJson());
      // TODO: navigate to post detail page
    } catch (e) {
      EasyLoading.showError('create post failed, try later');
    }
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
              // Get.toNamed(AppRoutes.application);
            },
          ),
        ],
      );
    },
  );
}
