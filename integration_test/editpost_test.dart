import 'dart:math';

import 'package:exchange/pages/edit_post/index.dart';
import 'package:exchange/common/routes/names.dart';
import 'package:exchange/pages/mine/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:exchange/main.dart' as app;
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';

class MockImagePicker extends Mock implements ImagePicker {}

class MockNetworkClient extends Mock implements Client {} // 假设你有一个网络客户端类用于上传图片

class MockState extends Mock implements EditPostState {} // 假设你的状态类

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'end to end test',
    () {
      final mockImagePicker = MockImagePicker();
      final mockNetworkClient = MockNetworkClient();
      final mockState = MockState();
      testWidgets(
        'Edit Post Test',
        (tester) async {
          app.main();
          await tester.pumpAndSettle();
          Get.toNamed(AppRoutes.mine);
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.tap(find.text('Login'));
          await tester.pumpAndSettle(); // 等待导航动画完成
          // 以下是登录测试，与你之前的代码相同
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(
              find.byType(TextField).at(0), 'leo@uwaterloo.ca');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), '123456');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          await tester.tap(find.text('My Post'));
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 4));

          final Finder popupMenuButtonFinder =
              find.byIcon(Icons.more_vert).at(0);
          await tester.tap(popupMenuButtonFinder);
          await tester.pumpAndSettle(); // Wait for the menu to open.
          await Future.delayed(const Duration(seconds: 2));

          final Finder SoldOptionFinder = find.text('Edit').at(0);
          await tester.tap(SoldOptionFinder);
          await tester
              .pumpAndSettle(); // Wait for any actions to complete after selection.
          await tester
              .pumpAndSettle(); // Wait for any actions to complete after selection.
          await Future.delayed(const Duration(seconds: 2));

          final Finder deleteImageButtonFinder = find.byIcon(Icons.cancel);
          await tester.tap(deleteImageButtonFinder);
          await tester.pumpAndSettle();

          var response = await http.get(Uri.parse("https://picsum.photos/50"));
          var bytes = response.bodyBytes;
          final editPostController = Get.find<EditPostController>();
          await editPostController.uploadImage(XFile.fromData(bytes));
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 10));
          final Finder firstTextFieldFinder = find.byType(TextField).at(0);
          final Finder secondTextFieldFinder = find.byType(TextField).at(1);
          final Finder thirdTextFieldFinder = find.byType(TextField).at(2);

// Clear the existing content and type 't' into the first text field
          await tester.tap(firstTextFieldFinder);
          await tester.pumpAndSettle();
          await tester.enterText(firstTextFieldFinder, ''); // Clear the text
          await tester.enterText(firstTextFieldFinder, 'test'); // Enter 't'
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

// Repeat for the second text field
          await tester.tap(secondTextFieldFinder);
          await tester.pumpAndSettle();
          await tester.enterText(secondTextFieldFinder, ''); // Clear the text
          await tester.enterText(secondTextFieldFinder, 'test'); // Enter 't'
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

// Repeat for the third text field
          await tester.tap(thirdTextFieldFinder);
          await tester.pumpAndSettle();
          await tester.enterText(thirdTextFieldFinder, ''); // Clear the text
          await tester.enterText(thirdTextFieldFinder, '90'); // Enter 't'
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          //final Finder scrollViewFinder = find.byType(ScrollView); // Replace with your actual ScrollView type
          //final Offset scrollAmount = Offset(0, -500); // Replace with the actual scroll amount needed
          //await tester.drag(scrollViewFinder, scrollAmount);
          //await tester.pumpAndSettle(); // Allow animations to settle

// Tap the 'Select Category' button or widget to open the category selector
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          final Finder selectCategoryButtonFinder = find.text(
              'Select Category'); // Replace with your actual key or finder
          await tester.tap(selectCategoryButtonFinder);
          await tester
              .pumpAndSettle(); // Wait for any pop-up animations to settle
          await tester
              .pumpAndSettle(); // Wait for any pop-up animations to settle
          await Future.delayed(const Duration(seconds: 2));

// Find and tap the desired category from the list
          final Finder desiredCategoryFinder = find
              .text('Other');
               // Use the actual text or key of the category
          await tester.tap(desiredCategoryFinder);
          await tester
              .pumpAndSettle(); // Wait for any pop-up animations to settle
          await tester
              .pumpAndSettle();
          await tester
              .pumpAndSettle(); // Wait for any pop-up animations to settle
          await tester
              .pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          //final Finder selectCategoryButtonFinder = find.text(
          //    'Select Category'); // Replace with your actual key or finder
          await tester.tap(selectCategoryButtonFinder);
          await tester
              .pumpAndSettle(); // Wait for any pop-up animations to settle
          await tester
              .pumpAndSettle(); // Wait for any pop-up animations to settle
          await Future.delayed(const Duration(seconds: 2));

// Find and tap the desired category from the list
          final Finder HousingCategoryFinder = find
              .text('Housing'); // Use the actual text or key of the category
          await tester.tap(HousingCategoryFinder);
          await tester
              .pumpAndSettle(); // Wait for any pop-up animations to settle
          await tester
              .pumpAndSettle();
          //final Finder selectCategoryButtonFinder = find.text(
          //    'Select Category');
          await tester.tap(selectCategoryButtonFinder);
          await tester
              .pumpAndSettle(); // Wait for any pop-up animations to settle
          await tester
              .pumpAndSettle();
          final Finder ElectronicsCategoryFinder = find
              .text('Electronics');
          await tester.tap(ElectronicsCategoryFinder);
          await tester
              .pumpAndSettle(); // Wait for any pop-up animations to settle
          await tester
              .pumpAndSettle();
          await tester.tap(selectCategoryButtonFinder);
          await tester
              .pumpAndSettle(); // Wait for any pop-up animations to settle
          await tester
              .pumpAndSettle();

          final Finder OtherCategoryFinder = find
              .text('Other');
          await tester.tap(OtherCategoryFinder);
          await tester
              .pumpAndSettle(); // Wait for any pop-up animations to settle
          await tester
              .pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
// Wait for any pop-up animations to settle
// Wait for selection to settle
          // Wait for any navigation or dialog to complete
          await tester.tap(find.text('Edit'));
          await tester
              .pumpAndSettle(); // Wait for any navigation or dialog to complete
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
/*
// Find the first ListTile by using find.byType and picking the first one
          final Finder firstGirdTileFinder = find.byType(GridTile).first;

// Tap on the first ListTile
          await tester.tap(firstGirdTileFinder);
          await tester
              .pumpAndSettle(); // Wait for any potential animations to finish
          await tester
              .pumpAndSettle();
          await tester
              .pumpAndSettle(); // Wait for any potential animations to finish
          await tester
              .pumpAndSettle();await tester
              .pumpAndSettle(); // Wait for any potential animations to finish
          await tester
              .pumpAndSettle();await tester
              .pumpAndSettle(); // Wait for any potential animations to finish
          await tester
              .pumpAndSettle();await tester
              .pumpAndSettle(); // Wait for any potential animations to finish
          await tester
              .pumpAndSettle();await tester
              .pumpAndSettle(); // Wait for any potential animations to finish
          await tester
              .pumpAndSettle();
          // Wait for any potential animations to finish
          await Future.delayed(const Duration(seconds: 2));
          final Finder scrollViewFinder = find.byType(SingleChildScrollView);

// Determine the amount to scroll down
// You might need to adjust the value based on the size of the content
          final double scrollAmount =
              500.0; // Scrolls 500 logical pixels down the screen

// Execute the scroll action
          await tester.drag(scrollViewFinder, Offset(0, -scrollAmount));
          await tester.pumpAndSettle(); // Let the scroll animation settle
          expect(find.text('Title: test'), findsOneWidget);
          expect(find.text('Price: \$90.0'), findsOneWidget);
          expect(find.text('Description: test'), findsOneWidget);
          expect(find.text('Category: OTHER'), findsOneWidget);

          expect(find.text('Name: Leo'), findsOneWidget);
          final Finder backButton = find.byTooltip(
              'Back'); // Flutter typically adds this tooltip by default
          await tester.tap(backButton);
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          Get.toNamed(AppRoutes.home);
          await tester.pumpAndSettle(); //
          await Future.delayed(const Duration(seconds: 2));
// 等待导航动画完成
          Finder sendButton = find.byKey(ValueKey('searchIconButton'));
          await tester.tap(sendButton);
          await tester.tap(sendButton);
          await tester.pump(); // Simulate the tap event.
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          final Finder searchInputField = find.byType(TextField);
          await tester.pumpAndSettle(); //

          await tester.enterText(searchInputField, 'test');
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          final Finder firstGridTile = find.byType(GridTile).at(0);
          await tester.pumpAndSettle(); //

          await Future.delayed(const Duration(seconds: 2));

          await tester.tap(firstGridTile);
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(); //
          await tester.pumpAndSettle(); //
          await tester.pumpAndSettle(); //

          await Future.delayed(const Duration(seconds: 2));

          await Future.delayed(const Duration(seconds: 2));
          await tester.drag(scrollViewFinder, Offset(0, -scrollAmount));
          await tester.pumpAndSettle(); // Let the scroll animation settle
          expect(find.text('Title: test'), findsOneWidget);
          expect(find.text('Price: \$90.0'), findsOneWidget);
          expect(find.text('Description: test'), findsOneWidget);
          expect(find.text('Category: OTHER'), findsOneWidget);
          expect(find.text('Name: Leo'), findsOneWidget);
          */
        },
      );

      // 对于登录失败的测试，可以采用类似的逻辑进行导航和验证
    },
  );
}
