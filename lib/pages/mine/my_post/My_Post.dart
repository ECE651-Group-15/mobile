import 'package:exchange/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:exchange/pages/home/index.dart';

class MyPostPage extends GetView<HomeController> {
   MyPostPage({Key? key}) : super(key: key);

  // 主视图
  Future<List<dynamic>> fetchCustomerPostedListings(String customerId, int page) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json'
    };

    var request = http.Request(
        'POST',
        Uri.parse('http://ec2-3-145-145-71.us-east-2.compute.amazonaws.com:8080/v1/api/listing-profile/get-customer-posted-listings')
    );

    request.body = json.encode({
      "page": page,
      "customerId": customerId
    });

    request.headers.addAll(headers);

    // 初始化postedListings为空列表
    List<dynamic> postedListings = [];
    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseBody);

      if (decodedResponse['code'] == 200) {
        print(responseBody);
        postedListings = decodedResponse['data']['postedListings'];
      } else {
        print(response.reasonPhrase);
        // 可选: 抛出异常或返回错误信息
      }
    }catch (e) {
      // 异常处理
      print('An error occurred: $e');
      // 可选: 抛出异常或返回错误信息
    }
    return postedListings;
  }
  // List<Map<String, String>> items = [
  //   {
  //     'image': 'https://picsum.photos/200/300',
  //     'text':
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
  //   },
  //   {
  //     'image': 'https://picsum.photos/200/300',
  //     'text':
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
  //   },
  //   {
  //     'image': 'https://picsum.photos/200/300',
  //     'text':
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
  //   },
  //   {
  //     'image': 'https://picsum.photos/200/300',
  //     'text':
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
  //   },
  //   {
  //     'image': 'https://picsum.photos/200/300',
  //     'text':
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
  //   },
  //   {
  //     'image': 'https://picsum.photos/200/300',
  //     'text':
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
  //   },
  //   {
  //     'image': 'https://picsum.photos/200/300',
  //     'text':
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
  //   },
  //   {
  //     'image': 'https://picsum.photos/200/300',
  //     'text':
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
  //   },
  //   {
  //     'image': 'https://picsum.photos/200/300',
  //     'text':
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
  //   },
  //   {
  //     'image': 'https://picsum.photos/200/300',
  //     'text':
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
  //   },
  //   // Add more items as needed
  // ];
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: const Text("My Post")),
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
             future: fetchCustomerPostedListings("b16f6fd7-fbe1-4665-8d03-ea8ec63ef78b", 0),
             builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return Center(child: CircularProgressIndicator());
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
                     return GridTile(
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
                                       items[index]['images'].isNotEmpty ? 'https://ece-651.oss-us-east-1.aliyuncs.com/${items[index]['images'][0] }': 'https://ece-651.oss-us-east-1.aliyuncs.com/default-image.jpg'
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
