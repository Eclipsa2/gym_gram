import 'package:flutter_test/flutter_test.dart';
import '../lib/auth_widgets/LoginPage.dart';
import 'package:flutter/material.dart';

void main() {
  // We are verifying if the login page displays correctly
  group('LoginPage', () {
    testWidgets('Login page displays correctly', (WidgetTester tester) async {
      // Build LoginPage widget
      await tester.pumpWidget(
        MaterialApp(
          home: LoginPage(
            tapSwitch: () {},
          ),
        ),
      );

      // Verify the presence of important UI elements
      expect(find.text('Welcome back, you\'ve been missed!'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.text('Not a member?'), findsOneWidget);
      expect(find.text('Register now'), findsOneWidget);
    });

    // testWidgets('Invalid login shows error dialog', (WidgetTester tester) async {
    //   // Build LoginPage widget
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: LoginPage(
    //         tapSwitch: () {},
    //       ),
    //     ),
    //   );

    //   // Trigger sign-in with invalid credentials
    //   await tester.enterText(find.byType(TextField).first, 'invalid@example.com');
    //   await tester.enterText(find.byType(TextField).last, 'password');
    //   await tester.tap(find.byType(ElevatedButton));
    //   await tester.pump();

    //   // Verify the error dialog is shown
    //   expect(find.text('Wrong username or password'), findsOneWidget);
    // });

    // Add more tests as per your requirements
  });
}
