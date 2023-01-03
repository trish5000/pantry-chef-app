// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dietary_preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DietaryPreference _$DietaryPreferenceFromJson(Map<String, dynamic> json) =>
    DietaryPreference()
      ..preference =
          $enumDecode(_$DietaryPreferenceEnumEnumMap, json['preference']);

Map<String, dynamic> _$DietaryPreferenceToJson(DietaryPreference instance) =>
    <String, dynamic>{
      'preference': _$DietaryPreferenceEnumEnumMap[instance.preference]!,
    };

const _$DietaryPreferenceEnumEnumMap = {
  DietaryPreferenceEnum.vegetarian: 0,
  DietaryPreferenceEnum.pescatarian: 1,
  DietaryPreferenceEnum.vegan: 2,
  DietaryPreferenceEnum.glutenFree: 3,
};
