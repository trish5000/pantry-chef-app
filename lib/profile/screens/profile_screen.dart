import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/navigation/top_level_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Future _logout() async {
    final userContextNotifier = ref.read(authProvider.notifier);
    userContextNotifier.logOut();

    final topLevel = ref.read(topLevelRouterProvider);
    topLevel.beamingHistory.clear();
    topLevel.beamToReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _logout,
      child: const Text('Log Out'),
    );
  }
}
