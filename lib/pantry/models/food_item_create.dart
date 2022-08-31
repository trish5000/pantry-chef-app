import 'package:json_annotation/json_annotation.dart';
part 'food_item_create.g.dart';

@JsonSerializable()
class FoodItemCreate {
  FoodItemCreate();

  String name = '';
  double quantity = 0.0;
  String unit = '';

  factory FoodItemCreate.fromJson(Map<String, dynamic> json) =>
      _$FoodItemCreateFromJson(json);
  Map<String, dynamic> toJson() => _$FoodItemCreateToJson(this);
}
