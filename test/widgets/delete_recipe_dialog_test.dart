import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_chef_app/recipes/widgets/delete_recipe_dialog.dart';

import '../fakes/fake_classes.dart';
import 'simple_material_app_widget.dart';

void main() {
  testWidgets('Delete recipe dialog - render smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      SimpleMaterialAppWidget(
        overrides: const [],
        child: DeleteRecipeDialog(recipeName: fakeRecipe().name),
      ),
    );

    final yesButton = find.text("Yes");
    expect(yesButton, findsOneWidget);

    final noButton = find.text("No");
    expect(noButton, findsOneWidget);
  });
}
