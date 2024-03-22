
import 'package:exchange/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/entities/post.dart';
import 'controller.dart';

class CompletedOrderScreen extends StatelessWidget {
  final CompletedOrderController controller = Get.find<CompletedOrderController>();

  CompletedOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Order Page"),
        actions: <Widget>[
          // No need for IconButton, we will have search bar below the AppBar
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.state.listings.isEmpty) {
                return const Center(
                  child: Text('No listings found.'),
                );
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    try {
                      Map<String, dynamic>? customerProfilesDetails =
                      await controller.getProfile(item.customerId ?? '');
                      Map<String, dynamic> newList = {
                        'listingDetails': item.toJson(),
                        'customerProfilesDetails': customerProfilesDetails,
                      };
                      Get.toNamed(AppRoutes.postDetails, arguments: newList);
                    } catch (e) {
                      print("Error fetching profile: $e");
                      // Handle the error or show an error message to the user
                    }
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
          Positioned(
            top: 6,
            right: 6,
            child: PopupMenuButton<String>(
              icon: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.more_vert, color: Colors.black),
                ),
              ),
              onSelected: (String result) {
                switch (result) {
                // case 'delete':
                //   controller.showDeleteConfirmationDialog(context, item['id']);
                //   break;
                  case 'markAsAvailable':
                    controller.markAsAvailable(item.toJson());
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
                const PopupMenuItem<String>(
                  value: 'markAsAvailable',
                  child: Text('Mark as Available'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
