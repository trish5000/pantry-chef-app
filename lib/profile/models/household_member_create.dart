import 'package:json_annotation/json_annotation.dart';
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
  List<DietaryPreferences>? dietaryPreferences;

  factory HouseholdMemberCreate.fromJson(Map<String, dynamic> json) =>
      _$HouseholdMemberCreateFromJson(json);
  Map<String, dynamic> toJson() => _$HouseholdMemberCreateToJson(this);
}

enum DietaryPreferences {
  @JsonValue(0)
  none,
  @JsonValue(1)
  vegetarian,
  @JsonValue(2)
  pescatarian,
  @JsonValue(3)
  vegan,
  @JsonValue(4)
  glutenFree,
}
