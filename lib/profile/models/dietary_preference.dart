import 'package:json_annotation/json_annotation.dart';
import 'package:pantry_chef_app/profile/models/dietary_preference_create.dart';

part 'dietary_preference.g.dart';

@JsonSerializable()
class DietaryPreference {
  DietaryPreference();

  DietaryPreferenceEnum preference = DietaryPreferenceEnum.vegan;

  factory DietaryPreference.fromJson(Map<String, dynamic> json) =>
      _$DietaryPreferenceFromJson(json);
  Map<String, dynamic> toJson() => _$DietaryPreferenceToJson(this);
}
