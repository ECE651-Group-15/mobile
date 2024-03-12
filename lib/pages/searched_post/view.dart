import 'package:exchange/common/entities/post.dart';
import 'package:exchange/pages/searched_post/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchMainScreen extends StatelessWidget {
  final SearchMainController controller = Get.find<SearchMainController>();

  SearchMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Home Page"),
        actions: <Widget>[
          // No need for IconButton, we will have search bar below the AppBar
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                controller.searchListings(value);
              },
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search for a post",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.state.listings.isEmpty) {
                return Center(
                  child: Text('No listings found.'),
                );
              } else {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: controller.state.listings.length,
                  itemBuilder: (context, index) {
                    var item = controller.state.listings[index];
                    return buildItemTile(
                        item); // Use your existing buildItemTile
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget buildItemTile(Data item) {
    String imageUrl = (item.images?.isNotEmpty ?? false)
        ? 'https://ece-651.oss-us-east-1.aliyuncs.com/${item.images?.first}'
        : 'https://ece-651.oss-us-east-1.aliyuncs.com/default-image.jpg';

    return GridTile(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Implement navigation to the details of the item
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              item.title ?? 'No title',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
