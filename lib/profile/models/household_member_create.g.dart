// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_member_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseholdMemberCreate _$HouseholdMemberCreateFromJson(
        Map<String, dynamic> json) =>
    HouseholdMemberCreate()
      ..firstName = json['first_name'] as String?
      ..lastName = json['last_name'] as String?
      ..userId = json['user_id'] as int?
      ..child = json['child'] as bool?
      ..dietaryPreferences = (json['dietary_preferences'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$DietaryPreferencesEnumMap, e))
          .toList();

Map<String, dynamic> _$HouseholdMemberCreateToJson(
        HouseholdMemberCreate instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user_id': instance.userId,
      'child': instance.child,
      'dietary_preferences': instance.dietaryPreferences
          ?.map((e) => _$DietaryPreferencesEnumMap[e]!)
          .toList(),
    };

const _$DietaryPreferencesEnumMap = {
  DietaryPreferences.none: 0,
  DietaryPreferences.vegetarian: 1,
  DietaryPreferences.pescatarian: 2,
  DietaryPreferences.vegan: 3,
  DietaryPreferences.glutenFree: 4,
};
