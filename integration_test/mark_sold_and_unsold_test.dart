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
        'navigate to login screen and verify login with correct username and password',
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

          await tester.tap(find.text('My Post'));
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle(); // 等待导航动画完成

          await Future.delayed(const Duration(seconds: 4));

          final Finder popupMenuButtonFinder =
              find.byIcon(Icons.more_vert).at(0);
          await tester.tap(popupMenuButtonFinder);
          await tester.pumpAndSettle(); // Wait for the menu to open.
          await Future.delayed(const Duration(seconds: 2));

          final Finder SoldOptionFinder = find.text('Mark as Sold').at(0);
          await tester.tap(SoldOptionFinder);
          await tester
              .pumpAndSettle(); // Wait for any actions to complete after selection.
          Get.toNamed(AppRoutes.mine);
          await tester
              .pumpAndSettle(); // Wait for any actions to complete after selection.
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.text('Completed Orders'));
          await tester
              .pumpAndSettle(); // Wait for any actions to complete after selection.
          await tester
              .pumpAndSettle(); // Wait for any actions to complete after selection.
          await tester
              .pumpAndSettle(); // Wait for any actions to complete after selection.
          await tester
              .pumpAndSettle(); // Wait for any actions to complete after selection.

          await Future.delayed(const Duration(seconds: 2));
          expect(find.text('used macbook for sale'), findsOneWidget);
          final Finder popupMenuButtonFinder2 =
              find.byIcon(Icons.more_vert).at(0);
          await tester.tap(popupMenuButtonFinder2);
          await tester.pumpAndSettle(); // Wait for the menu to open.
          await Future.delayed(const Duration(seconds: 2));
          final Finder UnsoldOptionFinder =
              find.text('Mark as Available').at(0);
          await tester.tap(UnsoldOptionFinder);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          final Finder backButton = find.byTooltip(
              'Back'); // Flutter typically adds this tooltip by default
          await tester.tap(backButton);
          await tester.pumpAndSettle();
          await tester
              .pumpAndSettle(); // Wait for any actions to complete after selection.

          expect(find.text('Logout'), findsWidgets);
        },
      );

      // 对于登录失败的测试，可以采用类似的逻辑进行导航和验证
    },
  );
}
