import 'package:json_annotation/json_annotation.dart';
part 'pantry_item_create.g.dart';

@JsonSerializable()
class PantryItemCreate {
  PantryItemCreate();

  String name = '';
  double quantity = 0.0;
  String unit = '';

  @JsonKey(name: "storage_location")
  late StorageLocation storageLocation;

  @JsonKey(name: 'date_added')
  DateTime dateAdded = DateTime.now();

  @JsonKey(name: 'use_by')
  DateTime useBy = DateTime.now();

  factory PantryItemCreate.fromJson(Map<String, dynamic> json) =>
      _$PantryItemCreateFromJson(json);
  Map<String, dynamic> toJson() => _$PantryItemCreateToJson(this);
}

enum StorageLocation {
  @JsonValue(0)
  fridge,
  @JsonValue(1)
  freezer,
  @JsonValue(2)
  pantry,
  @JsonValue(3)
  spiceRack
}
