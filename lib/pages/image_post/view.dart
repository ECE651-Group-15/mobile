import 'package:exchange/common/routes/names.dart';
import 'package:exchange/pages/image_post/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePostPage extends GetView<ImagePostController> {
  const ImagePostPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                child: Image.network(
                  'https://picsum.photos/400/300',
                  //fit: BoxFit.cover,
                ),
              ),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.home);
              // Add your logic to navigate or perform actions on button press
            },
            child: const Text(
              'View Seller Listings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        /*
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          child: Image.network(
            'https://picsum.photos/400/300',
            //fit: BoxFit.cover,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'This is an image',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                'Price: \$450',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Highlights',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('For Sale By: Owner'),
              Text('Condition: Used - Like new'),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Additional Details on Object ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Payment: Only  Accepted ✔',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        // Button to view seller listings
        Padding(
          padding: const EdgeInsets.all(16),

          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.home);
              // Add your logic to navigate or perform actions on button press
            },
            child: const Text(
              'View Seller Listings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        */
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePostController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("Image Post")),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
