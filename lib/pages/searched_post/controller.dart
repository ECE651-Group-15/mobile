import 'package:exchange/pages/searched_post/state.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/apis/post.dart'; // Adjust import based on your project structure
import '../../common/entities/post.dart'; // Adjust import based on your project structure

class SearchMainController extends GetxController {
  final state = SearchMainState();

  @override
  void onInit() {
    super.onInit();
    fetchInitialListings(); // You might want to fetch initial listings or leave this for the search function
  }

  Future<void> fetchInitialListings() async {
    // Implement initial fetch logic here if necessary
    // Example: searchListings('');
  }

  Future<void> searchListings(String query) async {
    EasyLoading.show(status: 'Loading...');

    // Assuming you have a method in your API class to fetch data based on a search query
    SearchMainRequestEntity request = SearchMainRequestEntity(title: query);
    try {
      SearchMainResponseEntity response = await PostApi.searchMain(request);
      print(response.toJson());
      if (response.code == 200 && response.data != null) {
        // Assuming `data` is a List of your items
        state.listings.value = response.data!;
        EasyLoading.dismiss();
      } else {
        EasyLoading.showError('Failed to fetch listings');
      }
    } catch (e) {
      print(e);
      EasyLoading.showError('Error: $e');
    }
  }

  Future<void> refreshUI() async {
    // You might call fetchInitialListings or keep the current search state
    fetchInitialListings();
  }
}
