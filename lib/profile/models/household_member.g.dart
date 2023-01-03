// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseholdMember _$HouseholdMemberFromJson(Map<String, dynamic> json) =>
    HouseholdMember()
      ..id = json['id'] as int
      ..headOfHouseholdId = json['head_of_household_id'] as int
      ..firstName = json['first_name'] as String
      ..lastName = json['last_name'] as String?
      ..userId = json['user_id'] as int?
      ..child = json['child'] as bool
      ..dietaryPreferences = (json['dietary_preferences'] as List<dynamic>)
          .map((e) => DietaryPreference.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$HouseholdMemberToJson(HouseholdMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'head_of_household_id': instance.headOfHouseholdId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user_id': instance.userId,
      'child': instance.child,
      'dietary_preferences': instance.dietaryPreferences,
    };
