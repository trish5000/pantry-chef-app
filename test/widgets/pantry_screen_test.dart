import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/pantry/models/food_item.dart';
import 'package:pantry_chef_app/pantry/screens/pantry_screen.dart';
import 'package:pantry_chef_app/pantry/services/pantry_service.dart';

import '../fakes/fake_classes.dart';
import '../fakes/mock_services.dart';
import 'simple_material_app_widget.dart';

void main() {
  late MockPantryService mockPantryService;
  late List<FoodItem> mockPantry;

  setUpAll(() {
    registerFallbackValue(fakeFoodItem);
    mockPantryService = MockPantryService();
    mockPantry = fakePantry();

    when(() => mockPantryService.getPantry())
        .thenAnswer((invocation) => Future(() => mockPantry));
  });

  testWidgets('Pantry Screen - render smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      SimpleMaterialAppWidget(
        overrides: [
          pantryServiceProvider.overrideWithValue(mockPantryService),
        ],
        child: const PantryScreen(),
      ),
    );

    await tester.pumpAndSettle();

    final pantryListView =
        tester.firstWidget(find.byType(ListView)) as ListView;
    final childCount = pantryListView.semanticChildCount;
    expect(childCount, equals(mockPantry.length));

    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);
  });
}
