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
          await tester.enterText(find.byType(TextField).at(0), 'leo@uwaterloo.ca');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), '123456');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          Get.toNamed(AppRoutes.home);
          await tester.pumpAndSettle(); //
          await Future.delayed(const Duration(seconds: 2));
// 等待导航动画完成
          Finder sendButton = find.byKey(ValueKey('searchIconButton'));
          await tester.tap(sendButton);
          await tester.pump(); // Simulate the tap event.
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          final Finder searchInputField = find.byType(TextField);
              await tester.pumpAndSettle(); //

              await tester.enterText(searchInputField, '2 phones');
              await tester.pumpAndSettle(); //
              await Future.delayed(const Duration(seconds: 2));

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
          expect(find.text('Title: 2 phones'), findsWidgets);


            },
      );

      // 对于登录失败的测试，可以采用类似的逻辑进行导航和验证
    },
  );
}
