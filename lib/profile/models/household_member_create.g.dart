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
          ?.map((e) =>
              DietaryPreferenceCreate.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$HouseholdMemberCreateToJson(
        HouseholdMemberCreate instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user_id': instance.userId,
      'child': instance.child,
      'dietary_preferences': instance.dietaryPreferences,
    };
