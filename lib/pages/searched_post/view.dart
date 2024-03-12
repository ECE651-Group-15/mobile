import 'package:exchange/common/routes/names.dart';
import 'package:exchange/common/store/store.dart';
import 'package:exchange/pages/searched_post/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../searched_post/controller.dart';

class SearchMainScreen extends StatelessWidget {
  final SearchMainController controller = Get.put(SearchMainController());

  SearchMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Get.find<UserStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Home Page"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: DataSearch(controller: controller));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () => controller.refreshUI(),
            child: Obx(() {
              var items = controller.state.listings;
              if (items.isEmpty) {
                return Center(child: Text("No items found"));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items[index];
                  return buildItemTile(item);
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget buildItemTile(dynamic item) {
    return GridTile(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.postDetails, arguments: item);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(item['images']?.isNotEmpty == true
                        ? 'https://ece-651.oss-us-east-1.aliyuncs.com/${item['images'][0]}'
                        : 'https://ece-651.oss-us-east-1.aliyuncs.com/default-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              item['title'] ?? 'No title',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final SearchMainController controller;

  DataSearch({required this.controller});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Trigger the search
    controller.searchListings(query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
