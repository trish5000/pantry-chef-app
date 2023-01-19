// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient()
  ..id = json['id'] as int
  ..name = json['name'] as String
  ..quantity = (json['quantity'] as num).toDouble()
  ..unit = json['unit'] as String;

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
    };

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe()
  ..userId = json['user_id'] as int
  ..id = json['id'] as int
  ..name = json['name'] as String
  ..servings = (json['servings'] as num).toDouble()
  ..procedure = json['procedure'] as String?
  ..ingredients = (json['ingredients'] as List<dynamic>)
      .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
      .toList()
  ..timestamp = DateTime.parse(json['timestamp'] as String);

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'user_id': instance.userId,
      'id': instance.id,
      'name': instance.name,
      'servings': instance.servings,
      'procedure': instance.procedure,
      'ingredients': instance.ingredients.map((e) => e.toJson()).toList(),
      'timestamp': instance.timestamp.toIso8601String(),
    };
