import 'package:json_annotation/json_annotation.dart';
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

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);
  Map<String, dynamic> toJson() => _$FoodItemToJson(this);
}
