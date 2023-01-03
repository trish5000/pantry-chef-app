import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_chef_app/profile/widgets/new_member_dialog.dart';

import 'simple_material_app_widget.dart';

void main() {
  testWidgets('New household member dialog - render smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const SimpleMaterialAppWidget(
        overrides: [],
        child: NewMemberDialog(),
      ),
    );

    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(2));
  });
}
