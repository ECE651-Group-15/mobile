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
        'receieve message test',
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
          await Future.delayed(const Duration(seconds: 2));
          Get.toNamed(AppRoutes.message);
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
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

          //Finder conversationItemToTap = find.byKey(Key('conversationItem_$indexToTap'));

// Simulate the tap
          int indexToTap =
              0; // Replace with the index of the item you want to tap
          Finder conversationItemToTap =
              find.byKey(Key('conversationItem_$indexToTap'));
          await tester.tap(conversationItemToTap);
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 5));
          expect(find.text('Your message 25 here'), findsWidgets);
          Get.close(4);
          Get.toNamed(AppRoutes.mine);
          await tester.pumpAndSettle(); //
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.text('Logout'));
          await tester.pumpAndSettle();
          Get.toNamed(AppRoutes.message);
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 10));

          expect(find.text('Please login first'), findsOneWidget);
        },
      );

      // 对于登录失败的测试，可以采用类似的逻辑进行导航和验证
    },
  );
}
