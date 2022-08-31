// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItemCreate _$FoodItemCreateFromJson(Map<String, dynamic> json) =>
    FoodItemCreate()
      ..name = json['name'] as String
      ..quantity = (json['quantity'] as num).toDouble()
      ..unit = json['unit'] as String;

Map<String, dynamic> _$FoodItemCreateToJson(FoodItemCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
    };
