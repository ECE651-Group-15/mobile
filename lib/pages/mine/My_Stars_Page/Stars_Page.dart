import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exchange/pages/home/index.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../common/routes/names.dart';
class StarsPage extends GetView<HomeController> {
  const StarsPage({Key? key}) : super(key: key);

  Future<List<dynamic>> fetchStarredListings(String customerId, int page, int pageSize) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json'
    };

    var request = http.Request('POST', Uri.parse('http://ec2-3-145-145-71.us-east-2.compute.amazonaws.com:8080/v1/api/listing-profile/starred-listings'));
    request.body = json.encode({
      "customerId": customerId,
      "page": page,
      "pageSize": pageSize
    });
    request.headers.addAll(headers);
    List<dynamic> postedListings = [];
    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> parsedJson = jsonDecode(responseBody);
      if (parsedJson['code']== 200) {
        // 这里可以根据需要进一步处理响应体
        print(responseBody);
        postedListings = parsedJson['data']['starredListings'];
      } else {
        print("Failed to fetch starred listings: ${response.reasonPhrase}");
      }

    } catch (e) {
      print("Exception caught: $e");
      // 这里可以处理异常情况
    }
    return postedListings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Liked Post")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 假设 AppRoutes.createPost 是你定义的路由
          Get.toNamed(AppRoutes.createPost);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<dynamic>>(
            future: fetchStarredListings(
                "b16f6fd7-fbe1-4665-8d03-ea8ec63ef78b", 1,1),
            builder: (BuildContext context,
                AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // 假设 items 是从 snapshot.data 获取的数据
                var items = snapshot.data ?? [];
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var item = items[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PostDetailsPage(item: item)),
                        );
                      },
                      child: GridTile(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        items[index]['images'].isNotEmpty
                                            ? 'https://ece-651.oss-us-east-1.aliyuncs.com/${items[index]['images'][0] }'
                                            : 'https://ece-651.oss-us-east-1.aliyuncs.com/default-image.jpg'
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                items[index]['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
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

class PostDetailsPage extends StatelessWidget {
  final dynamic item;

  PostDetailsPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = item['images'];

    return Scaffold(
      appBar: AppBar(
        title: Text(item['title']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
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
                      String imageUrl =
                          'https://ece-651.oss-us-east-1.aliyuncs.com/${images[index]}';
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                      );
                    },
                  ),
                )
              else
                Image.network(
                  'https://ece-651.oss-us-east-1.aliyuncs.com/default-image.jpg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 16),
              OutlinedTextBox(text: 'Title: ${item['title']}'),
              OutlinedTextBox(text: 'Price: \$${item['price']}'),
              OutlinedTextBox(text: 'Category: ${item['category']}'),
              OutlinedTextBox(text: 'Description: ${item['description']}'),
            ],
          ),
        ),
      ),
    );
  }
}