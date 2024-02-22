import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'index.dart';

class CreatePostPage extends GetView<CreatePostController> {
  CreatePostPage({Key? key}) : super(key: key);

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePostController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Create Post"),
            actions: [
              FilledButton(
                onPressed: controller.createPost,
                child: const Text("Create"),
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
                      maxLines: 10,
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
                  ListTile(
                    onTap: () async {
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      controller.uploadImage(image);
                    },
                    title: const Text("Choose Image"),
                    subtitle:
                        const Text("You can choose a image from your gallery"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => controller.state.images.length > 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InkWell(
                              onTap: () {
                                showBarModalBottomSheet(
                                  context: context,
                                  builder: (context) => ListTile(
                                    title: const Text("Delete Image"),
                                    trailing: const Icon(Icons.delete),
                                    onTap: () => {
                                      controller.state.images.clear(),
                                      Get.back(),
                                    },
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://ece-651.oss-us-east-1.aliyuncs.com/${controller.state.images[0]}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    // child: GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3,
                    //     crossAxisSpacing: 8,
                    //     mainAxisSpacing: 8,
                    //   ),
                    //   itemCount: 9,
                    //   itemBuilder: (context, index) {
                    //     return ClipRRect(
                    //       borderRadius: BorderRadius.circular(8),
                    //       child: Image.network(
                    //         // "https://picsum.photos/seed/picsum/200/200",
                    //         "https://ece651.oss-cn-hangzhou.aliyuncs.com/image_picker_F92ABC5B-ACAD-418E-9362-0C89589E1B5E-34048-0000352AF353F147.jpg",
                    //         fit: BoxFit.cover,
                    //       ),
                    //     );
                    //   },
                    // ),
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
