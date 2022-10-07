import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_chef_app/pantry/models/food_item_create.dart';
import 'package:pantry_chef_app/pantry/widgets/new_input_dialog.dart';

import 'simple_material_app_widget.dart';

void main() {
  testWidgets('New input dialog - render smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const SimpleMaterialAppWidget(
        overrides: [],
        child: NewInputDialog(),
      ),
    );

    final nameField = find.bySemanticsLabel('food name');
    expect(nameField, findsOneWidget);

    final amountField = find.bySemanticsLabel('amount');
    expect(amountField, findsOneWidget);

    final unitField = find.bySemanticsLabel('units');
    expect(unitField, findsOneWidget);

    final locationSelector =
        find.byType(DropdownButtonFormField<StorageLocation>);
    expect(locationSelector, findsOneWidget);

    final addFoodButton = find.byType(TextButton);
    expect(addFoodButton, findsOneWidget);

    expect(tester.widget<TextButton>(addFoodButton).enabled, isFalse);

    await tester.enterText(nameField, 'Pizza dough');
    await tester.pumpAndSettle();
    expect(tester.widget<TextButton>(addFoodButton).enabled, isFalse);

    await tester.enterText(amountField, '6');
    await tester.pumpAndSettle();
    expect(tester.widget<TextButton>(addFoodButton).enabled, isFalse);

    await tester.enterText(unitField, 'balls');
    await tester.pumpAndSettle();
    expect(tester.widget<TextButton>(addFoodButton).enabled, isFalse);

    await tester.tap(locationSelector);
    await tester.pumpAndSettle();

    final pantryLocation = find.bySemanticsLabel('FRIDGE');
    expect(pantryLocation, findsOneWidget);
    await tester.tap(pantryLocation);
    await tester.pumpAndSettle();
    expect(tester.widget<TextButton>(addFoodButton).enabled, isTrue);
  });
}
