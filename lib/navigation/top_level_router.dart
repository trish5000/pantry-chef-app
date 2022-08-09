import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/dashboard/screens/dashboard_screen.dart';

final topLevelRouterProvider = Provider((ref) {
  const tabRoutes = [
    'home',
    'pantry',
    'recipelibrary',
    'profile',
    'explore',
  ];
  final tabRoutesRegEx = tabRoutes.map((tab) => '($tab)').join('|');

  final delegate = BeamerDelegate(
    initialPath: '/home',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        RegExp(r'\/' + tabRoutesRegEx + '.*'): (ctx, state, data) =>
            const DashboardScreen(),
      },
    ),
  );

  return delegate;
});
