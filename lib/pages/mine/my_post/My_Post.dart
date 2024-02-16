import 'package:exchange/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:exchange/pages/home/index.dart';
import 'package:exchange/pages/home/widgets/widgets.dart';

class MyPostPage extends GetView<HomeController> {
  const MyPostPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const HelloWidget();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> items = [
      {
        'image': 'https://picsum.photos/200/300',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
      },
      {
        'image': 'https://picsum.photos/200/300',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
      },
      {
        'image': 'https://picsum.photos/200/300',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
      },
      {
        'image': 'https://picsum.photos/200/300',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
      },
      {
        'image': 'https://picsum.photos/200/300',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
      },
      {
        'image': 'https://picsum.photos/200/300',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
      },
      {
        'image': 'https://picsum.photos/200/300',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
      },
      {
        'image': 'https://picsum.photos/200/300',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
      },
      {
        'image': 'https://picsum.photos/200/300',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
      },
      {
        'image': 'https://picsum.photos/200/300',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
      },
      // Add more items as needed
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("My Post")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.createPost);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GridTile(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: IconButton(
                          icon: Image.network(
                            items[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                          iconSize: 50,
                          onPressed: () {
                            String imageUrl = items[index]['image']!;
                            Get.toNamed(AppRoutes.imagePost,
                                arguments: imageUrl);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        items[index]['text']!,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
