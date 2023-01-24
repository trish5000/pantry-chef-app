import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/recipes/models/recipe.dart';
import 'package:pantry_chef_app/recipes/screens/library_screen.dart';
import 'package:pantry_chef_app/recipes/services/recipe_service.dart';

import '../fakes/fake_classes.dart';
import '../fakes/mock_services.dart';
import 'simple_material_app_widget.dart';

void main() {
  late MockRecipeService mockRecipeService;
  late List<Recipe> mockLibrary;

  setUpAll(() {
    registerFallbackValue(fakePantryItem);
    mockRecipeService = MockRecipeService();
    mockLibrary = fakeLibrary();

    when(() => mockRecipeService.getRecipes())
        .thenAnswer((invocation) => Future(() => mockLibrary));
  });

  testWidgets('Library Screen - render smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      SimpleMaterialAppWidget(
        overrides: [
          recipeServiceProvider.overrideWithValue(mockRecipeService),
        ],
        child: const LibraryScreen(),
      ),
    );

    await tester.pumpAndSettle();

    final libraryGridView =
        tester.firstWidget(find.byType(GridView)) as GridView;
    final childCount = libraryGridView.semanticChildCount;
    expect(childCount, equals(mockLibrary.length));

    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);

    await tester.tap(fab);
    await tester.pumpAndSettle();

    final dialog = find.byType(Dialog);
    expect(dialog, findsOneWidget);
  });
}
