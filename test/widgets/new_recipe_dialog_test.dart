import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_chef_app/recipes/widgets/new_recipe_dialog.dart';

import 'simple_material_app_widget.dart';

void main() {
  testWidgets('New input dialog - render smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const SimpleMaterialAppWidget(
        overrides: [],
        child: NewRecipeDialog(),
      ),
    );

    final ingredientsHeader = find.text('Ingredients');
    expect(ingredientsHeader, findsOneWidget);

    final procedureHeader = find.text('Procedure');
    expect(procedureHeader, findsOneWidget);

    final ingredientField = find.bySemanticsLabel('ingredient');
    expect(ingredientField, findsNothing);

    final addIngredientButton = find.text('Add Ingredient');
    expect(addIngredientButton, findsOneWidget);
    await tester.tap(addIngredientButton);
    await tester.pumpAndSettle();

    expect(ingredientField, findsOneWidget);
  });
}
