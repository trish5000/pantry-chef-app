import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(3));

    final addFoodButton = find.byType(TextButton);
    expect(addFoodButton, findsOneWidget);
  });
}
