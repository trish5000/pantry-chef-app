import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/dashboard/screens/dashboard_screen.dart';
import 'package:pantry_chef_app/pantry/services/pantry_service.dart';

import '../fakes/fake_classes.dart';
import '../fakes/mock_services.dart';
import 'simple_material_app_widget.dart';

void main() {
  testWidgets('Dashboard screen - render smoke test',
      (WidgetTester tester) async {
    final mockPantryService = MockPantryService();
    when(() => mockPantryService.getPantry())
        .thenAnswer((invocation) => Future(() => fakePantry()));

    final router = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '/': (_, __, ___) => const DashboardScreen(),
        },
      ),
    );

    await tester.pumpWidget(
      SimpleMaterialAppWidget(
        overrides: [pantryServiceProvider.overrideWithValue(mockPantryService)],
        child: MaterialApp.router(
          routeInformationParser: BeamerParser(),
          routerDelegate: router,
        ),
      ),
    );

    router.beamToNamed('/');
    await tester.pumpAndSettle();

    final homeTab = find.text('HOME');
    expect(homeTab, findsOneWidget);
    await tester.tap(homeTab);
    await tester.pumpAndSettle();

    final homeText = find.textContaining('HOME SCREEN');
    expect(homeText, findsOneWidget);

    final pantryTab = find.text('PANTRY');
    expect(pantryTab, findsOneWidget);
    await tester.tap(pantryTab);
    await tester.pumpAndSettle();

    final pantryText = find.textContaining('My Pantry');
    expect(pantryText, findsOneWidget);

    final profileTab = find.text('PROFILE');
    expect(profileTab, findsOneWidget);
    await tester.tap(profileTab);
    await tester.pumpAndSettle();

    final profileText = find.textContaining('PROFILE SCREEN');
    expect(profileText, findsOneWidget);

    final libraryTab = find.text('RECIPE LIBRARY');
    expect(libraryTab, findsOneWidget);
    await tester.tap(libraryTab);
    await tester.pumpAndSettle();

    final libraryText = find.textContaining('RECIPE LIBRARY');
    expect(libraryText, findsOneWidget);

    final exploreTab = find.text('EXPLORE');
    expect(exploreTab, findsOneWidget);
    await tester.tap(exploreTab);
    await tester.pumpAndSettle();

    final exploreText = find.textContaining('Explore SCREEN');
    expect(exploreText, findsOneWidget);
  });
}
