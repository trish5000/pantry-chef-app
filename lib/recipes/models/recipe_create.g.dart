// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientCreate _$IngredientCreateFromJson(Map<String, dynamic> json) =>
    IngredientCreate()
      ..name = json['name'] as String
      ..quantity = (json['quantity'] as num).toDouble()
      ..unit = json['unit'] as String;

Map<String, dynamic> _$IngredientCreateToJson(IngredientCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
    };

RecipeCreate _$RecipeCreateFromJson(Map<String, dynamic> json) => RecipeCreate()
  ..name = json['name'] as String
  ..procedure = json['procedure'] as String?
  ..ingredients = (json['ingredients'] as List<dynamic>)
      .map((e) => IngredientCreate.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$RecipeCreateToJson(RecipeCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'procedure': instance.procedure,
      'ingredients': instance.ingredients,
    };
