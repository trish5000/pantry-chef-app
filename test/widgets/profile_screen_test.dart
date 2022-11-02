import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/navigation/top_level_router.dart';
import 'package:pantry_chef_app/profile/screens/profile_screen.dart';

import '../fakes/mock_services.dart';
import 'simple_material_app_widget.dart';

void main() {
  late MockBeamerDelegate mockDelegate;

  setUpAll(() {
    mockDelegate = MockBeamerDelegate();
    when((() => mockDelegate.beamingHistory)).thenReturn([]);
  });

  testWidgets('Log in screen - render smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      SimpleMaterialAppWidget(
        overrides: [topLevelRouterProvider.overrideWithValue(mockDelegate)],
        child: const ProfileScreen(),
      ),
    );

    await tester.pumpAndSettle();

    final logOutButton = find.byType(OutlinedButton);
    expect(logOutButton, findsOneWidget);

    await tester.tap(logOutButton);
    await tester.pumpAndSettle();
    verify((() => mockDelegate.beamingHistory.clear()));
    verify((() => mockDelegate.beamToReplacementNamed('/login')));
  });
}
