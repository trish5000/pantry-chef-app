import 'package:json_annotation/json_annotation.dart';

import 'food_item_create.dart';
part 'food_item.g.dart';

@JsonSerializable()
class FoodItem {
  FoodItem();
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

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);
  Map<String, dynamic> toJson() => _$FoodItemToJson(this);
}
