import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_chef_app/pantry/models/food_item_create.dart';
import 'package:pantry_chef_app/pantry/widgets/food_item_detail.dart';

import '../fakes/fake_classes.dart';
import 'simple_material_app_widget.dart';

void main() {
  testWidgets('Food item detail - render smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      SimpleMaterialAppWidget(
        overrides: const [],
        child: FoodItemDetail(foodItem: fakeFoodItem),
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

    expect(tester.widget<TextButton>(addFoodButton).enabled, isTrue);

    await tester.enterText(nameField, '');
    await tester.pumpAndSettle();
    expect(tester.widget<TextButton>(addFoodButton).enabled, isFalse);
  });
}
