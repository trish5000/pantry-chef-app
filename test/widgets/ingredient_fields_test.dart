import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_chef_app/recipes/models/recipe_create.dart';
import 'package:pantry_chef_app/recipes/widgets/ingredient_fields.dart';

import 'simple_material_app_widget.dart';

void main() {
  void mockUpdateIngredient(int index, IngredientCreate updated) {}
  void mockDeleteIngredient(int index) {}

  testWidgets('Ingredient Fields - render smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(SimpleMaterialAppWidget(
      overrides: const [],
      child: Material(
        child: IngredientFields(
          index: 1,
          ingredient: IngredientCreate(),
          updateIngredient: mockUpdateIngredient,
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
  });
}
