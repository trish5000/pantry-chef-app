import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Ingredient {
  Ingredient();

  int id = 0;
  String name = '';
  double quantity = 0.0;
  String unit = '';

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Recipe {
  Recipe();

  @JsonKey(name: 'user_id')
  int userId = 0;

  int id = 0;
  String name = '';
  double servings = 0.0;
  String? procedure;
  List<Ingredient> ingredients = [];
  DateTime timestamp = DateTime.now().toUtc();

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
