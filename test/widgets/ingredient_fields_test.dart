import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_chef_app/recipes/models/recipe_create.dart';
import 'package:pantry_chef_app/recipes/widgets/ingredient_fields.dart';

import 'simple_material_app_widget.dart';

void main() {
  late void Function(int index, IngredientCreate updated) updateCallback;
  late IngredientCreate updatedIngredient;
  void mockDeleteIngredient(int index) {}

  setUpAll(() {
    updateCallback = (int index, IngredientCreate updated) {
      updatedIngredient = updated;
    };
  });

  testWidgets('Ingredient Fields - render smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(SimpleMaterialAppWidget(
      overrides: const [],
      child: Material(
        child: IngredientFields(
          index: 1,
          ingredient: IngredientCreate(),
          updateIngredient: updateCallback,
          deleteIngredient: mockDeleteIngredient,
        ),
      ),
    ));

    final amountField = find.bySemanticsLabel('amount');
    expect(amountField, findsOneWidget);

    final unitField = find.bySemanticsLabel('unit');
    expect(unitField, findsOneWidget);

    final ingredientField = find.bySemanticsLabel('ingredient');
    expect(ingredientField, findsOneWidget);

    final expectedIngredient = IngredientCreate()
      ..name = 'rice'
      ..quantity = 5
      ..unit = 'cups';

    await tester.enterText(amountField, expectedIngredient.quantity.toString());
    await tester.enterText(unitField, expectedIngredient.unit);
    await tester.enterText(ingredientField, expectedIngredient.name);
    await tester.pumpAndSettle();

    expect(updatedIngredient.name, equals(expectedIngredient.name));
    expect(updatedIngredient.quantity, equals(expectedIngredient.quantity));
    expect(updatedIngredient.unit, equals(expectedIngredient.unit));
  });
}
