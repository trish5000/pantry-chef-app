import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/authentication/screens/login.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
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
    guards: [
      BeamGuard(
        pathPatterns: ['/login'],
        guardNonMatching: true,
        beamToNamed: (origin, target) => '/login',
        check: (ctx, location) {
          final auth = ref.read(authProvider);
          return auth.loggedIn;
        },
      )
    ],
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/login': (context, state, data) => const LoginScreen(),
        // ignore: prefer_interpolation_to_compose_strings
        RegExp(r'\/' + tabRoutesRegEx + '.*'): (ctx, state, data) =>
            const DashboardScreen(),
      },
    ),
  );

  return delegate;
});
