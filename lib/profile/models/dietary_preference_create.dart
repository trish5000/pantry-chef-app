import 'package:json_annotation/json_annotation.dart';

part 'dietary_preference_create.g.dart';

enum DietaryPreferenceEnum {
  @JsonValue(0)
  vegetarian,
  @JsonValue(1)
  pescatarian,
  @JsonValue(2)
  vegan,
  @JsonValue(3)
  glutenFree,
}

@JsonSerializable()
class DietaryPreferenceCreate {
  DietaryPreferenceCreate();

  DietaryPreferenceEnum? preference;

  factory DietaryPreferenceCreate.fromJson(Map<String, dynamic> json) =>
      _$DietaryPreferenceCreateFromJson(json);
  Map<String, dynamic> toJson() => _$DietaryPreferenceCreateToJson(this);
}
