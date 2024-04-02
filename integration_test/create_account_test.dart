import 'package:exchange/common/routes/names.dart';
import 'package:exchange/pages/mine/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:exchange/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
      'navigate to sign-up page and create account successfully',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Navigate to the 'Mine' or profile page
        Get.toNamed(AppRoutes.mine);
        await tester
            .pumpAndSettle(); // Wait for navigation animation to complete
        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle(); // 等待导航动画完成
        // Tap on 'Don't have an account? Sign up' button to navigate to the sign-up screen
        // If it's a TextButton, replace TextButton with the type of button used in your app
        final signUpButtonFinder =
            find.widgetWithText(TextButton, "Don't have an account? Sign up");
        //await tester.ensureVisible(signUpButtonFinder);
        await tester.pumpAndSettle();
        await tester.tap(signUpButtonFinder);
        await tester
            .pumpAndSettle(); // Wait for navigation animation to complete

        // Enter the email address
        await Future.delayed(const Duration(seconds: 2));
        await tester.enterText(find.byType(TextField), 'test@uwaterloo.ca');
        final ContinueButtonFinder =
            find.widgetWithText(ElevatedButton, "Continue");
        await tester.pumpAndSettle();
        await tester.tap(ContinueButtonFinder);
        await tester
            .pumpAndSettle(); // Wait for navigation animation to complete
        // Enter the password on the sign-up screen

// Check if the error message 'This email has been used' is shown
        expect(find.text('This email has been used'), findsOneWidget);
        await tester.enterText(find.byType(TextField), '999');

        ///ContinueButtonFinder = find.widgetWithText(ElevatedButton, "Continue");
        await Future.delayed(const Duration(seconds: 2));
        await tester.pumpAndSettle();
        await tester.tap(ContinueButtonFinder);
        await tester.pumpAndSettle();
        expect(find.text('Please enter a valid email address'), findsOneWidget);
        await Future.delayed(const Duration(seconds: 2));
        await tester.enterText(find.byType(TextField), '');

        await tester.pumpAndSettle();
        await tester.tap(ContinueButtonFinder);
        await tester.pumpAndSettle();
        expect(find.text('Please enter your email address'), findsOneWidget);

        await tester.enterText(find.byType(TextField), '99999@uwaterloo.ca');
        await tester.pumpAndSettle();
        await tester.tap(ContinueButtonFinder);
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'Leo2');
        final Continue2ButtonFinder =
            find.widgetWithText(ElevatedButton, "Continue");
        await tester.pumpAndSettle();
        await tester.tap(Continue2ButtonFinder);
        await tester
            .pumpAndSettle(); // Wait for navigation animation to complete
        await tester.enterText(find.byType(TextField), '123456');

        // Tap on the checkboxes to agree to Terms of Use and Privacy Policy
        await tester.tap(find.byType(Checkbox).at(0)); // Terms of Use
        await tester.tap(find.byType(Checkbox).at(1)); // Privacy Policy
        await tester.pumpAndSettle();

        // Tap on the 'Sign up' button to submit the form
        await tester.tap(find.widgetWithText(ElevatedButton, 'Sign up'));
        await tester.pumpAndSettle();

        // Verify that the registration success message appears
        expect(find.text('registration success'), findsOneWidget);

        // Tap on 'Return to login page' to navigate back to login
        await tester.tap(find.text('Return to login page'));
        await tester.pumpAndSettle();

        // Verify that user is navigated back to the login page
        await Future.delayed(const Duration(seconds: 2));
        await tester.enterText(
            find.byType(TextField).at(0), '99999@uwaterloo.ca');
        await Future.delayed(const Duration(seconds: 2));
        await tester.enterText(find.byType(TextField).at(1), '123456');
        await Future.delayed(const Duration(seconds: 2));
        await tester.tap(find.byType(ElevatedButton));
        await Future.delayed(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        await Future.delayed(const Duration(seconds: 2));
        expect(find.byType(MinePage), findsOneWidget);
      },
    );

    // You can add more tests for failure scenarios here
  });
}
