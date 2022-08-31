import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_chef_app/dashboard/screens/dashboard_screen.dart';
import 'package:pantry_chef_app/dashboard/widgets/dashboard_tab.dart';

import 'simple_material_app_widget.dart';

void main() {
  testWidgets('Dashboard screen - render smoke test',
      (WidgetTester tester) async {
    final router = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '/': (_, __, ___) => const DashboardScreen(),
        },
      ),
    );

    await tester.pumpWidget(
      SimpleMaterialAppWidget(
        overrides: const [],
        child: MaterialApp.router(
          routeInformationParser: BeamerParser(),
          routerDelegate: router,
        ),
      ),
    );

    router.beamToNamed('/');
    await tester.pumpAndSettle();

    for (var i = 0; i < 5; i++) {
      final tab = find.byWidgetPredicate(
        (widget) => widget is DashboardTab && widget.tabIndex == i,
      );
      expect(tab, findsOneWidget);

      final otherTabs = find.byWidgetPredicate(
          (widget) => widget is DashboardTab && widget.tabIndex != i);
      expect(otherTabs, findsNWidgets(4));
    }

    router.beamToNamed('/home');
    await tester.pumpAndSettle();

    final homeText = find.textContaining('HOME');
    expect(homeText, findsOneWidget);
  });
}
