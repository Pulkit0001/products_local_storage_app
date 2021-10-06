// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:products_storage_app/data_models/product_data_model.dart';

import 'package:products_storage_app/main.dart';
import 'package:products_storage_app/services/storage_services/sqlite_database.dart'
    as product_db;

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
  test('Counter value should be incremented', () async {
    //final counter = Counter();
    WidgetsFlutterBinding.ensureInitialized();
    await product_db.createInstance();
    await product_db.addProduct(Product(
        id: 0,
        name: "Apple",
        price: 10,
        salePrice: 15,
        description: "Nutritious food",
        colors: ["Red", "Golden"],
        stores: [Store(address: "HERE"), Store(address: 'There')]));

    //expect(counter.value, 1);
  });
}
