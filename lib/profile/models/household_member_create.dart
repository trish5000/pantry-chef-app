import 'package:json_annotation/json_annotation.dart';
import 'package:pantry_chef_app/profile/models/dietary_preference_create.dart';
part 'household_member_create.g.dart';

@JsonSerializable()
class HouseholdMemberCreate {
  HouseholdMemberCreate();

  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "last_name")
  String? lastName;

  @JsonKey(name: "user_id")
  int? userId;

  bool? child;

  @JsonKey(name: "dietary_preferences")
  List<DietaryPreferenceCreate>? dietaryPreferences;

  factory HouseholdMemberCreate.fromJson(Map<String, dynamic> json) =>
      _$HouseholdMemberCreateFromJson(json);
  Map<String, dynamic> toJson() => _$HouseholdMemberCreateToJson(this);
}
