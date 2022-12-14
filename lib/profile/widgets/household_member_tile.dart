import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pantry_chef_app/profile/models/household_member.dart';
import 'package:pantry_chef_app/profile/models/household_member_create.dart';
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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).splashColor,
      ),
      child: SizedBox(
        width: 100,
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

  Widget checkboxEnum(DietaryPreferences pref) {
    return Row(
      children: [
        Checkbox(
          visualDensity:
              const VisualDensity(vertical: VisualDensity.minimumDensity),
          value: widget.householdMember.dietaryPreferences.contains(pref),
          onChanged: (checked) {
            setState(() {
              checked!
                  ? member.dietaryPreferences.add(pref)
                  : member.dietaryPreferences.remove(pref);
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
            checkboxEnum(DietaryPreferences.none),
            checkboxEnum(DietaryPreferences.vegetarian),
            checkboxEnum(DietaryPreferences.pescatarian),
            checkboxEnum(DietaryPreferences.vegan),
            checkboxEnum(DietaryPreferences.glutenFree),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
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
          padding:
              const EdgeInsets.only(left: 20, right: 12, bottom: 14, top: 14),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 36,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Text(widget.householdMember.firstName[0]
                              .toLowerCase()),
                        ),
                        const SizedBox(width: 10),
                        name(),
                      ],
                    ),
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
