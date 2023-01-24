import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/dashboard/widgets/dashboard_bottom_bar.dart';
import 'package:pantry_chef_app/home/screens/home_screen.dart';
import 'package:pantry_chef_app/pantry/screens/pantry_screen.dart';
import 'package:pantry_chef_app/profile/screens/profile_screen.dart';
import 'package:pantry_chef_app/recipes/screens/library_screen.dart';
import 'package:pantry_chef_app/temp_screens.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final _beamerKey = GlobalKey<BeamerState>();

  final _router = BeamerDelegate(
    initialPath: '/home',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/home': (context, state, data) => const HomeScreen(),
        '/pantry': (context, state, data) => const PantryScreen(),
        '/recipelibrary': (context, state, data) => const LibraryScreen(),
        '/profile': (context, state, data) => const ProfileScreen(),
        '/explore': (context, state, data) => const ExploreScreen(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Beamer(
        routerDelegate: _router,
        key: _beamerKey,
      ),
      bottomNavigationBar: DashboardBottomBar(beamerKey: _beamerKey),
    );
  }
}
