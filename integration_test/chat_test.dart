import 'package:exchange/common/routes/names.dart';
import 'package:exchange/pages/mine/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:exchange/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'end to end test',
    () {
      testWidgets(
        'send message test',
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
              find.byType(TextField).at(0), 'leo2@uwaterloo.ca');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), '123456');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();


          await Future.delayed(const Duration(seconds: 2));
          Get.toNamed(AppRoutes.home);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 10));

          //inal Finder firstimage = find.byType(GridTile).at(0);
          await tester.tap(find.byKey(ValueKey('1')));
          await tester.pumpAndSettle(); // 等待导航动画完成
          await Future.delayed(const Duration(seconds: 10));
          await tester.tap(find.text('Chat'));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 10));
          Finder messageTextBox = find.byType(TextField);
          await tester.enterText(messageTextBox, 'Your message 24 here');
          Finder sendButton = find.byKey(ValueKey('sendButton'));

// Tap the send button
          await tester.tap(sendButton);
          await tester.pump(); // Simulate the tap event.

// ... continue with any further steps, like settling animations ...
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 10));
          Get.toNamed(AppRoutes.message);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 10));
          // To tap on a conversation item with a specific key
          int indexToTap =
              0; // Replace with the index of the item you want to tap
          Finder conversationItemToTap =
              find.byKey(Key('conversationItem_$indexToTap'));

// Simulate the tap
          await tester.tap(conversationItemToTap);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 10));

          expect(find.text('Your message 24 here'), findsWidgets);
          Get.close(4);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 10));

          //await tester.tap(find.byKey(ValueKey('6')));
          Finder searchButton = find.byKey(ValueKey('searchIconButton'));
          await tester.tap(searchButton);
          await tester.pump(); // Simulate the tap event.
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          final Finder searchInputField = find.byType(TextField);
          await tester.pumpAndSettle(); //

          await tester.enterText(searchInputField, 'Brand New 4 Seat Couch Set With a Table');
          await tester.pumpAndSettle(); //
          await tester.pumpAndSettle();
          final Finder firstGridTile = find.byType(GridTile).at(0);

          await tester.pumpAndSettle(); //
          await tester.pumpAndSettle(); //
          await tester.pumpAndSettle(); //
          await tester.tap(firstGridTile);
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(); //
          await tester.pumpAndSettle(); //
          await tester.pumpAndSettle(); //

          await Future.delayed(const Duration(seconds: 2));// 等待导航动画完成
          await Future.delayed(const Duration(seconds: 10));
          await tester.tap(find.text('Send Offer'));
          await tester.pumpAndSettle(); // 等待导航动画完成
          expect(find.text('Chat Page'), findsOneWidget);
          Finder message2TextBox = find.byType(TextField);
          await tester.enterText(message2TextBox, 'Your message 25 here');
          await tester.tap(sendButton);
          await tester.pump(); // Simulate the tap event.

// ... continue with any further steps, like settling animations ...
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 10));
          Get.close(4);
          await tester.pumpAndSettle(); // 等待导航动画完成
          await Future.delayed(const Duration(seconds: 2));

          Get.toNamed(AppRoutes.mine);
          await tester.pumpAndSettle(); // 等待导航动画完成
          await Future.delayed(const Duration(seconds: 2));

          await tester.tap(find.text('Logout'));
          await tester.pumpAndSettle(); // 等待导航动画完成
        },
      );

      // 对于登录失败的测试，可以采用类似的逻辑进行导航和验证
    },
  );
}
