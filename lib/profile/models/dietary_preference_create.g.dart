// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dietary_preference_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DietaryPreferenceCreate _$DietaryPreferenceCreateFromJson(
        Map<String, dynamic> json) =>
    DietaryPreferenceCreate()
      ..preference = $enumDecodeNullable(
          _$DietaryPreferenceEnumEnumMap, json['preference']);

Map<String, dynamic> _$DietaryPreferenceCreateToJson(
        DietaryPreferenceCreate instance) =>
    <String, dynamic>{
      'preference': _$DietaryPreferenceEnumEnumMap[instance.preference],
    };

const _$DietaryPreferenceEnumEnumMap = {
  DietaryPreferenceEnum.vegetarian: 0,
  DietaryPreferenceEnum.pescatarian: 1,
  DietaryPreferenceEnum.vegan: 2,
  DietaryPreferenceEnum.glutenFree: 3,
};
