// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) => FoodItem()
  ..id = json['id'] as int
  ..userId = json['user_id'] as int
  ..timestamp = DateTime.parse(json['timestamp'] as String)
  ..name = json['name'] as String
  ..quantity = (json['quantity'] as num).toDouble()
  ..unit = json['unit'] as String;

Map<String, dynamic> _$FoodItemToJson(FoodItem instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'timestamp': instance.timestamp.toIso8601String(),
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
    };
