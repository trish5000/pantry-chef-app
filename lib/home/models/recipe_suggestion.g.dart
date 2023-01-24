// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeSuggestion _$RecipeSuggestionFromJson(Map<String, dynamic> json) =>
    RecipeSuggestion()
      ..recipe = Recipe.fromJson(json['recipe'] as Map<String, dynamic>)
      ..missingIngredients = (json['missing_ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList()
      ..pantryItems = (json['pantry_items'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$RecipeSuggestionToJson(RecipeSuggestion instance) =>
    <String, dynamic>{
      'recipe': instance.recipe.toJson(),
      'missing_ingredients':
          instance.missingIngredients.map((e) => e.toJson()).toList(),
      'pantry_items': instance.pantryItems.map((e) => e.toJson()).toList(),
    };
