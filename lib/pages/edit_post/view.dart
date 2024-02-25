import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'index.dart';

class EditPostPage extends GetView<EditPostController> {
  EditPostPage({Key? key}) : super(key: key);
  final id = Get.arguments;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditPostController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Post"),
            actions: [
              FilledButton(
                onPressed: () {
                  controller.editPost(context,id);
                },
                child: const Text("Edit"),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Obx(
                      () => controller.state.images.isNotEmpty
                          ? Container(
                              height: 150, // 调整为合适的高度
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.state.images.length +
                                    1, // 包含添加按钮
                                itemBuilder: (context, index) {
                                  if (index == controller.state.images.length) {
                                    // 添加图片的按钮
                                    return GestureDetector(
                                      onTap: () async {
                                        final XFile? image =
                                            await picker.pickImage(
                                                source: ImageSource.gallery);
                                        controller.uploadImage(image);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            // 添加边框
                                            color: Colors.black, // 边框颜色
                                            width: 1, // 边框宽度
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8), // 边框圆角
                                        ),
                                        width: 100, // 调整为合适的宽度
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, // 垂直方向居中对齐
                                          children: <Widget>[
                                            Icon(Icons.add,
                                                color: Theme.of(context)
                                                    .primaryColor), // 图标
                                            Text('Add photo',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    // 显示图片
                                    return Row(
                                      children: [
                                        Container(
                                          width: 100, // 图片宽度
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Image.network(
                                                'https://ece-651.oss-us-east-1.aliyuncs.com/${controller.state.images[index]}',
                                                fit: BoxFit.cover,
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.cancel),
                                                color: Colors.white,
                                                onPressed: () {
                                                  controller.state.images
                                                      .removeAt(index);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            )
                          : SizedBox(
                              height: 150,
                              child: OutlinedButton(
                                onPressed: () async {
                                  final XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  controller
                                      .uploadImage(image); // Handle add photo
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Theme.of(context).dividerColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add,
                                          color:
                                              Theme.of(context).primaryColor),
                                      SizedBox(width: 8.0),
                                      Text('Add photo',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 18,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ), // 如果没有图片，显示一个空的容器
                    ),
                    // Other widgets...
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextField(
                      controller: controller.titleController,
                      decoration: const InputDecoration(
                        hintText: "Please input title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextField(
                      controller: controller.descriptionController,
                      decoration: const InputDecoration(
                        hintText: "Please input description",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextField(
                      controller: controller.priceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*')),
                      ],
                      decoration: const InputDecoration(
                        hintText: "What's the product price?",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Obx(
                    () => ListTile(
                      title: const Text("Select Category"),
                      subtitle: controller.state.category == ""
                          ? const Text("Please select a category")
                          : Text("You selected ${controller.state.category}"),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        showBarModalBottomSheet(
                          context: context,
                          builder: (context) => ListView(
                            shrinkWrap: false,
                            children: [
                              ListTile(
                                title: const Text("Online Services"),
                                onTap: () {
                                  controller.state.category = "ONLINE_SERVICES";
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: const Text("Housing"),
                                onTap: () {
                                  controller.state.category = "HOUSING";
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: const Text("Electronics"),
                                onTap: () {
                                  controller.state.category = "ELECTRONICS";
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: const Text("Clothing"),
                                onTap: () {
                                  controller.state.category = "CLOTHING";
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: const Text("Other"),
                                onTap: () {
                                  controller.state.category = "OTHER";
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
