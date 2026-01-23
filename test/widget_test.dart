import 'package:flutter_test/flutter_test.dart';

import 'package:scanvault/app.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ScanVaultApp());

    // Verify that the app starts with ScanVault title
    expect(find.text('ScanVault'), findsOneWidget);
  });
}
