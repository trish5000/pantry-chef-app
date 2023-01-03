import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/profile/models/household_member.dart';
import 'package:pantry_chef_app/profile/widgets/household_member_tile.dart';
import 'package:pantry_chef_app/recipes/models/recipe_create.dart';

import '../fakes/fake_classes.dart';
import 'simple_material_app_widget.dart';

void main() {
  late void Function(int index, IngredientCreate updated) updateCallback;
  late StateNotifierProvider<UserContextNotifier, UserContext> mockAuthProvider;
  late HouseholdMember member;
  void mockRemoveMember(int index) {}

  setUpAll(() {
    mockAuthProvider = StateNotifierProvider<UserContextNotifier, UserContext>(
      (ref) => UserContextNotifier()..logIn(fakeUser, 'fakeToken'),
    );

    member = fakeHouseholdMember;
  });

  testWidgets('Household member tile - render smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      SimpleMaterialAppWidget(
        overrides: [
          authProvider.overrideWithProvider(mockAuthProvider),
        ],
        child: Material(
          child: HouseholdMemberTile(
            index: 1,
            householdMember: member,
            removeMember: mockRemoveMember,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final checkBox = find.byType(Checkbox).first;
    expect(checkBox, findsWidgets);
  });
}
