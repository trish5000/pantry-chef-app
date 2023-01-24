// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pantry_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PantryItem _$PantryItemFromJson(Map<String, dynamic> json) => PantryItem()
  ..id = json['id'] as int
  ..userId = json['user_id'] as int
  ..timestamp = DateTime.parse(json['timestamp'] as String)
  ..name = json['name'] as String
  ..quantity = (json['quantity'] as num).toDouble()
  ..unit = json['unit'] as String
  ..storageLocation =
      $enumDecode(_$StorageLocationEnumMap, json['storage_location'])
  ..dateAdded = DateTime.parse(json['date_added'] as String)
  ..useBy = DateTime.parse(json['use_by'] as String);

Map<String, dynamic> _$PantryItemToJson(PantryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'timestamp': instance.timestamp.toIso8601String(),
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
