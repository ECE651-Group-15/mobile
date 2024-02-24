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
                    padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Obx(
                        () => controller.state.images.isNotEmpty
                        ? Container(
                      height: 150, // 调整为合适的高度
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.state.images.length + 1, // 包含添加按钮
                        itemBuilder: (context, index) {
                          if (index == controller.state.images.length) {
                            // 添加图片的按钮
                            return GestureDetector(
                              onTap: () async {
                                final XFile? image =
                                await picker.pickImage(source: ImageSource.gallery);
                                controller.uploadImage(image);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all( // 添加边框
                                    color: Colors.black, // 边框颜色
                                    width: 1, // 边框宽度
                                  ),
                                  borderRadius: BorderRadius.circular(8), // 边框圆角
                                ),
                                width: 100, // 调整为合适的宽度
                                child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center, // 垂直方向居中对齐
                                children: <Widget>[
                                  Icon(Icons.add, color: Theme.of(context).primaryColor), // 图标
                                  Text('Add photo', style: TextStyle(color: Theme.of(context).primaryColor)),
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
                                  margin: EdgeInsets.symmetric(horizontal: 5),
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
                                          controller.state.images.removeAt(index);
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
                              onPressed: () async{
                                final XFile? image =
                                    await picker.pickImage(source: ImageSource.gallery);
                                controller.uploadImage(image);// Handle add photo
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Theme.of(context).dividerColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, color: Theme.of(context).primaryColor),
                                  SizedBox(width: 8.0),
                                  Text('Add photo', style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18,
                                  )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),// 如果没有图片，显示一个空的容器
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
                  // ListTile(
                  //   onTap: () async {
                  //     final XFile? image =
                  //     await picker.pickImage(source: ImageSource.gallery);
                  //     controller.uploadImage(image);
                  //   },
                  //   title: const Text("Choose Image"),
                  //   subtitle:
                  //   const Text("You can choose a image from your gallery"),
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // Obx(
                  //       () => controller.state.images.isNotEmpty
                  //       ? SingleChildScrollView( // 使用 Expanded 包裹
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 16),
                  //       child: GridView.builder(
                  //         shrinkWrap: true, // 使 GridView 自适应高度
                  //         physics: NeverScrollableScrollPhysics(), // 因为已在 SingleChildScrollView 中
                  //         itemCount: controller.state.images.length,
                  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //           crossAxisCount: 3, // 一行显示3张图片
                  //           crossAxisSpacing: 10, // 水平间距
                  //           mainAxisSpacing: 10, // 垂直间距
                  //         ),
                  //         itemBuilder: (context, index) {
                  //           return InkWell(
                  //             onTap: () {
                  //               showBarModalBottomSheet(
                  //                 context: context,
                  //                 builder: (context) => ListTile(
                  //                   title: const Text("Delete Image"),
                  //                   trailing: const Icon(Icons.delete),
                  //                   onTap: () {
                  //                     controller.state.images.removeAt(index); // 改为删除特定图片
                  //                     Get.back();
                  //                   },
                  //                 ),
                  //               );
                  //             },
                  //             child: ClipRRect(
                  //               borderRadius: BorderRadius.circular(8),
                  //               child: Image.network(
                  //                 'https://ece-651.oss-us-east-1.aliyuncs.com/${controller.state.images[index]}',
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   )
                  //       : Container(), // 如果没有图片，显示一个空的容器
                  // )

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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}