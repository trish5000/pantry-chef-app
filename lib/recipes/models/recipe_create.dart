import 'package:json_annotation/json_annotation.dart';

part 'recipe_create.g.dart';

@JsonSerializable()
class IngredientCreate {
  IngredientCreate();

  String name = '';
  double quantity = 0.0;
  String unit = '';

  factory IngredientCreate.fromJson(Map<String, dynamic> json) =>
      _$IngredientCreateFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientCreateToJson(this);
}

@JsonSerializable()
class RecipeCreate {
  RecipeCreate();

  String name = '';
  double servings = 0.0;
  String? procedure;
  List<IngredientCreate> ingredients = [];

  factory RecipeCreate.fromJson(Map<String, dynamic> json) =>
      _$RecipeCreateFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeCreateToJson(this);
}
