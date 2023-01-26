import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/navigation/top_level_router.dart';
import 'package:pantry_chef_app/profile/models/household_member.dart';
import 'package:pantry_chef_app/profile/models/household_member_create.dart';
import 'package:pantry_chef_app/profile/services/household_service.dart';
import 'package:pantry_chef_app/profile/state/household.dart';
import 'package:pantry_chef_app/profile/widgets/household_member_tile.dart';
import 'package:pantry_chef_app/profile/widgets/new_member_dialog.dart';

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

  void updateSuggestionFilters(int householdSize) {
    final householdStateNotifier = ref.read(householdStateProvider.notifier);
    householdStateNotifier.specifyHouseholdSize(householdSize);
  }

  void removeMember(int index) async {
    final householdService = ref.read(householdServiceProvider);
    await householdService.removeHouseholdMember(members[index]);

    updateSuggestionFilters(members.length - 1);
    _fetchHousehold();
  }

  Future _logout() async {
    final userContextNotifier = ref.read(authProvider.notifier);
    userContextNotifier.logOut();

    final topLevel = ref.read(topLevelRouterProvider);
    topLevel.beamingHistory.clear();
    topLevel.beamToReplacementNamed('/login');
  }

  Widget householdSection() {
    return Expanded(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Household',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 5),
          loading
              ? const CircularProgressIndicator()
              : Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: ((context, index) => HouseholdMemberTile(
                          index: index,
                          householdMember: members[index],
                          removeMember: removeMember,
                        )),
                    itemCount: members.length,
                  ),
                ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 6),
              child: GestureDetector(
                onTap: addNewMember,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, size: 18),
                    Text(
                      "Add Member",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addNewMember() async {
    final newMemberCreate = await showDialog<HouseholdMemberCreate>(
      context: context,
      builder: (_) => const NewMemberDialog(),
    );
    if (newMemberCreate == null) return;

    final householdService = ref.read(householdServiceProvider);
    await householdService.addMember(newMemberCreate);

    updateSuggestionFilters(members.length + 1);
    _fetchHousehold();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            householdSection(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: OutlinedButton(
                onPressed: _logout,
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
