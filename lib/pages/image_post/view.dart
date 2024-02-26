import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class OutlinedTextBox extends StatelessWidget {
  final String text;

  OutlinedTextBox({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Container(
        width: screenWidth - 32,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}

class PostDetailsPage extends GetView<ImagePostController> {
  const PostDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var detailedPost = controller.state.detailedPost.value;
    final title = detailedPost['listingDetails']?['title'] ?? 'Default Title';
    final images =
        detailedPost['listingDetails']?['images'] as List<dynamic>? ?? [];
    final price = detailedPost['listingDetails']?['price'] ?? '';
    final category = detailedPost['listingDetails']?['category'] ?? '';
    final description = detailedPost['listingDetails']?['description'] ?? '';

    final customerName =
        detailedPost['customerDetails']?['name'] ?? 'No Name Provided';
    final customerEmail =
        detailedPost['customerDetails']?['email'] ?? 'No Email Provided';
    final customerPhone =
        detailedPost['customerDetails']?['phone'] ?? 'No Phone Provided';
    final customerAvatarUrl = detailedPost['customerDetails']?['avatarUrl'] ??
        'https://example.com/default_avatar.png';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (images.isNotEmpty)
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.network(
                          'https://ece-651.oss-us-east-1.aliyuncs.com/${images[index]}',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              OutlinedTextBox(text: 'Title: $title'),
              OutlinedTextBox(text: 'Price: \$$price'),
              OutlinedTextBox(text: 'Category: $category'),
              OutlinedTextBox(text: 'Description: $description'),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(customerAvatarUrl),
                      radius: 40,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: $customerName',
                              style: TextStyle(fontSize: 18)),
                          Text('Email: $customerEmail',
                              style: TextStyle(fontSize: 18)),
                          Text('Phone: $customerPhone',
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
