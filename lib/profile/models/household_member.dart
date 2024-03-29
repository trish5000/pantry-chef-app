import 'package:json_annotation/json_annotation.dart';
import 'package:pantry_chef_app/profile/models/dietary_preference.dart';

part 'household_member.g.dart';

@JsonSerializable()
class HouseholdMember {
  HouseholdMember();
  int id = 0;

  @JsonKey(name: "head_of_household_id")
  int headOfHouseholdId = 0;

  @JsonKey(name: "first_name")
  String firstName = '';

  @JsonKey(name: "last_name")
  String? lastName;

  @JsonKey(name: "user_id")
  int? userId;

  bool child = false;

  @JsonKey(name: "dietary_preferences")
  List<DietaryPreference> dietaryPreferences = [];

  factory HouseholdMember.fromJson(Map<String, dynamic> json) =>
      _$HouseholdMemberFromJson(json);
  Map<String, dynamic> toJson() => _$HouseholdMemberToJson(this);
}
