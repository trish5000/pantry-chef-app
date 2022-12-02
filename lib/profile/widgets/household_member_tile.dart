import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/profile/models/household_member.dart';
import 'package:pantry_chef_app/profile/models/household_member_create.dart';

class HouseholdMemberTile extends ConsumerStatefulWidget {
  final HouseholdMember householdMember;
  const HouseholdMemberTile({
    Key? key,
    required this.householdMember,
  }) : super(key: key);

  @override
  ConsumerState<HouseholdMemberTile> createState() =>
      _HouseholdMemberTileState();
}

class _HouseholdMemberTileState extends ConsumerState<HouseholdMemberTile> {
  Widget ageDropdown() {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).splashColor,
      ),
      child: IntrinsicWidth(
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: 16, left: 6, right: 2),
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
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
              .toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }

  Widget name() {
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Text(
        widget.householdMember.firstName!,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget checkboxEnum(DietaryPreferences pref) {
    return Row(children: [
      Checkbox(
        value: widget.householdMember.dietaryPreferences.contains(pref),
        onChanged: (_) {},
      ),
      Text(pref.name),
    ]);
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
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            checkboxEnum(DietaryPreferences.vegan),
            checkboxEnum(DietaryPreferences.glutenFree),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Row(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                child: Text(widget.householdMember.firstName![0].toLowerCase()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  name(),
                  const SizedBox(height: 5),
                  ageDropdown(),
                ],
              ),
            ),
            const SizedBox(width: 14),
            dietaryPreferences(),
          ],
        ),
      ),
    );
  }
}
