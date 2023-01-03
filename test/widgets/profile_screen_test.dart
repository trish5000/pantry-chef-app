import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/navigation/top_level_router.dart';
import 'package:pantry_chef_app/profile/models/household_member.dart';
import 'package:pantry_chef_app/profile/screens/profile_screen.dart';
import 'package:pantry_chef_app/profile/services/household_service.dart';

import '../fakes/fake_classes.dart';
import '../fakes/mock_services.dart';
import 'simple_material_app_widget.dart';

void main() {
  late MockBeamerDelegate mockDelegate;
  late MockHouseholdService mockHouseholdService;
  late StateNotifierProvider<UserContextNotifier, UserContext> mockAuthProvider;
  late List<HouseholdMember> mockHousehold;

  setUpAll(() {
    mockHousehold = fakeHousehold();

    mockDelegate = MockBeamerDelegate();
    when((() => mockDelegate.beamingHistory)).thenReturn([]);

    mockHouseholdService = MockHouseholdService();
    when(() => mockHouseholdService.getHousehold())
        .thenAnswer((invocation) => Future(() => mockHousehold));

    mockAuthProvider = StateNotifierProvider<UserContextNotifier, UserContext>(
      (ref) => UserContextNotifier()..logIn(fakeUser, 'fakeToken'),
    );
  });

  testWidgets('Profile screen - render smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      SimpleMaterialAppWidget(
        overrides: [
          topLevelRouterProvider.overrideWithValue(mockDelegate),
          householdServiceProvider.overrideWithValue(mockHouseholdService),
          authProvider.overrideWithProvider(mockAuthProvider),
        ],
        child: const ProfileScreen(),
      ),
    );

    await tester.pumpAndSettle();

    final householdListView =
        tester.firstWidget(find.byType(ListView)) as ListView;
    final childCount = householdListView.semanticChildCount;
    expect(childCount, equals(mockHousehold.length));

    final logOutButton = find.byType(OutlinedButton);
    expect(logOutButton, findsOneWidget);

    await tester.tap(logOutButton);
    await tester.pump();
    verify((() => mockDelegate.beamingHistory.clear()));
    verify((() => mockDelegate.beamToReplacementNamed('/login')));
  });
}
