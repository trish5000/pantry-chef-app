import 'package:json_annotation/json_annotation.dart';

import 'pantry_item_create.dart';
part 'pantry_item.g.dart';

@JsonSerializable()
class PantryItem {
  PantryItem();
  int id = 0;

  @JsonKey(name: 'user_id')
  int userId = 0;

  DateTime timestamp = DateTime.now().toUtc();
  String name = '';
  double quantity = 0.0;
  String unit = '';

  @JsonKey(name: "storage_location")
  late StorageLocation storageLocation;

  @JsonKey(name: 'date_added')
  DateTime dateAdded = DateTime.now();

  @JsonKey(name: 'use_by')
  DateTime useBy = DateTime.now();

  factory PantryItem.fromJson(Map<String, dynamic> json) =>
      _$PantryItemFromJson(json);
  Map<String, dynamic> toJson() => _$PantryItemToJson(this);
}
