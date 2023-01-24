import 'package:json_annotation/json_annotation.dart';
import 'package:pantry_chef_app/recipes/models/recipe.dart';

part 'recipe_suggestion.g.dart';

@JsonSerializable(explicitToJson: true)
class RecipeSuggestion {
  RecipeSuggestion();

  late Recipe recipe;

  @JsonKey(name: 'missing_ingredients')
  List<Ingredient> missingIngredients = [];

  @JsonKey(name: 'pantry_items')
  List<Ingredient> pantryItems = [];

  factory RecipeSuggestion.fromJson(Map<String, dynamic> json) =>
      _$RecipeSuggestionFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeSuggestionToJson(this);
}
