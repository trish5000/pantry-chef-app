// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItemCreate _$FoodItemCreateFromJson(Map<String, dynamic> json) =>
    FoodItemCreate()
      ..name = json['name'] as String
      ..quantity = (json['quantity'] as num).toDouble()
      ..unit = json['unit'] as String
      ..storageLocation =
          $enumDecode(_$StorageLocationEnumMap, json['storage_location'])
      ..dateAdded = DateTime.parse(json['date_added'] as String)
      ..useBy = DateTime.parse(json['use_by'] as String);

Map<String, dynamic> _$FoodItemCreateToJson(FoodItemCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'storage_location': _$StorageLocationEnumMap[instance.storageLocation]!,
      'date_added': instance.dateAdded.toIso8601String(),
      'use_by': instance.useBy.toIso8601String(),
    };

const _$StorageLocationEnumMap = {
  StorageLocation.fridge: 0,
  StorageLocation.freezer: 1,
  StorageLocation.pantry: 2,
  StorageLocation.spiceRack: 3,
};
