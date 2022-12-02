import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/navigation/top_level_router.dart';
import 'package:pantry_chef_app/profile/models/household_member.dart';
import 'package:pantry_chef_app/profile/services/household_service.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  List<HouseholdMember> members = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _fetchHousehold();
  }

  void _fetchHousehold() async {
    loading = true;
    final householdService = ref.read(householdServiceProvider);
    final householdMembers = await householdService.getHousehold();

    setState(() {
      members = householdMembers;
      loading = false;
    });
  }

  Future _logout() async {
    final userContextNotifier = ref.read(authProvider.notifier);
    userContextNotifier.logOut();

    final topLevel = ref.read(topLevelRouterProvider);
    topLevel.beamingHistory.clear();
    topLevel.beamToReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        children: [
          loading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: ((context, index) => Row(
                          children: [
                            Text(members[index].userId?.toString() ??
                                "no user id"),
                            const SizedBox(width: 10),
                            Text(members[index].firstName ?? "no first name"),
                            const SizedBox(width: 10),
                            Text(members[index].lastName ?? "no last name"),
                          ],
                        )),
                    itemCount: members.length,
                  ),
                ),
          OutlinedButton(
            onPressed: _logout,
            child: const Text('Log Out'),
          )
        ],
      ),
    );
  }
}
