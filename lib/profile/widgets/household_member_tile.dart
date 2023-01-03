import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/profile/models/dietary_preference.dart';
import 'package:pantry_chef_app/profile/models/dietary_preference_create.dart';
import 'package:pantry_chef_app/profile/models/household_member.dart';
import 'package:pantry_chef_app/profile/services/household_service.dart';

typedef RemoveMember = void Function(int index);

class HouseholdMemberTile extends ConsumerStatefulWidget {
  final HouseholdMember householdMember;
  final int index;
  final RemoveMember? removeMember;
  const HouseholdMemberTile({
    Key? key,
    required this.index,
    required this.householdMember,
    required this.removeMember,
  }) : super(key: key);

  @override
  ConsumerState<HouseholdMemberTile> createState() =>
      _HouseholdMemberTileState();
}

class _HouseholdMemberTileState extends ConsumerState<HouseholdMemberTile> {
  late HouseholdMember member;

  @override
  void initState() {
    super.initState();
    member = widget.householdMember;
  }

  void _updateMember() async {
    final householdService = ref.read(householdServiceProvider);
    await householdService.updateHouseholdMember(member);
  }

  Widget ageDropdown() {
    return Container(
      height: 40,
      width: 104,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).splashColor,
      ),
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 10, left: 6, right: 2),
        ),
        isDense: true,
        alignment: Alignment.center,
        value: widget.householdMember.child ? 'CHILD' : 'ADULT',
        items: ['ADULT', 'CHILD']
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          final child = value == 'CHILD';
          if (child != member.child) {
            member.child = child;
            _updateMember();
          }
        },
      ),
    );
  }

  Widget name() {
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Text(
        widget.householdMember.firstName,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget checkboxEnum(DietaryPreferenceEnum pref) {
    return Row(
      children: [
        Checkbox(
          visualDensity:
              const VisualDensity(vertical: VisualDensity.minimumDensity),
          value: widget.householdMember.dietaryPreferences
              .any((e) => e.preference == pref),
          onChanged: (checked) {
            setState(() {
              checked!
                  ? member.dietaryPreferences
                      .add(DietaryPreference()..preference = pref)
                  : member.dietaryPreferences
                      .removeWhere((e) => e.preference == pref);
            });
            _updateMember();
          },
        ),
        Text(pref.name),
      ],
    );
  }

  Widget dietaryPreferences() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            checkboxEnum(DietaryPreferenceEnum.vegetarian),
            checkboxEnum(DietaryPreferenceEnum.pescatarian),
            checkboxEnum(DietaryPreferenceEnum.vegan),
            checkboxEnum(DietaryPreferenceEnum.glutenFree),
          ],
        ),
      ],
    );
  }

  Widget nameAndAvatar() {
    return Row(
      children: [
        CircleAvatar(
          child: Text(widget.householdMember.firstName[0].toLowerCase()),
        ),
        const SizedBox(width: 10),
        name(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userContext = ref.watch(authProvider);
    final loading = userContext.user == null;

    return loading
        ? const CircularProgressIndicator()
        : Slidable(
            enabled: userContext.user!.id != widget.householdMember.userId,
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: ((context) => widget.removeMember!(widget.index)),
                  icon: Icons.delete,
                  backgroundColor: Colors.grey,
                )
              ],
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 12,
                  bottom: 14,
                  top: 14,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 36,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          nameAndAvatar(),
                          const SizedBox(height: 20),
                          ageDropdown(),
                        ],
                      ),
                    ),
                    dietaryPreferences(),
                  ],
                ),
              ),
            ),
          );
  }
}
