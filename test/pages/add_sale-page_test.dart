import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/pages/add_sale_page.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/sales_provider.dart';

void main() {
  testWidgets('AddSalePage form saves a sale', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => SalesProvider(),
        child: const MaterialApp(home: AddSalePage()),
      ),
    );

    // Fill buyer name
    await tester.enterText(find.byType(TextFormField).at(0), 'Test Buyer');

    // Fill price
    await tester.enterText(find.byType(TextFormField).at(1), '35');

    // Tap save button
    await tester.tap(find.text('Save Sale'));
    await tester.pump();

    // Expect success snackbar
    expect(find.text('Sale added successfully'), findsOneWidget);
  });
}
