import 'package:faker/faker.dart';
import 'package:pantry_chef_app/pantry/models/food_item.dart';
import 'package:pantry_chef_app/pantry/models/food_item_create.dart';
import 'package:pantry_chef_app/recipes/models/recipe.dart';
import 'package:pantry_chef_app/recipes/models/recipe_create.dart';

final _faker = Faker();
FoodItem get fakeFoodItem => FoodItem()
  ..name = _faker.lorem.word()
  ..quantity = _faker.randomGenerator.decimal()
  ..unit = _faker.lorem.word()
  ..dateAdded = _faker.date.dateTime()
  ..useBy = _faker.date.dateTime()
  ..storageLocation = _faker.randomGenerator.element(StorageLocation.values);

FoodItemCreate get fakeFoodItemCreate => FoodItemCreate()
  ..name = _faker.lorem.word()
  ..quantity = _faker.randomGenerator.decimal()
  ..unit = _faker.lorem.word()
  ..dateAdded = _faker.date.dateTime()
  ..useBy = _faker.date.dateTime()
  ..storageLocation = _faker.randomGenerator.element(StorageLocation.values);

List<FoodItem> fakePantry() {
  final foodItemCount = _faker.randomGenerator.integer(300, min: 1);
  return List<FoodItem>.generate(foodItemCount, (index) => fakeFoodItem);
}

Ingredient get fakeIngredient => Ingredient()
  ..name = _faker.lorem.word()
  ..quantity = _faker.randomGenerator.decimal()
  ..unit = _faker.lorem.word();

IngredientCreate get fakeIngredientCreate => IngredientCreate()
  ..name = _faker.lorem.word()
  ..quantity = _faker.randomGenerator.decimal()
  ..unit = _faker.lorem.word();

Recipe fakeRecipe() {
  final ingredientCount = _faker.randomGenerator.integer(3);
  final ingredients =
      List<Ingredient>.generate(ingredientCount, (index) => fakeIngredient);

  return Recipe()
    ..name = _faker.lorem.word()
    ..ingredients = ingredients
    ..procedure = _faker.lorem.sentence();
}

RecipeCreate fakeRecipeCreate() {
  final ingredientCount = _faker.randomGenerator.integer(3);
  final ingredients = List<IngredientCreate>.generate(
      ingredientCount, (index) => fakeIngredientCreate);

  return RecipeCreate()
    ..name = _faker.lorem.word()
    ..ingredients = ingredients
    ..procedure = _faker.lorem.sentence();
}

List<Recipe> fakeLibrary() {
  final recipeCount = _faker.randomGenerator.integer(300);
  return List<Recipe>.generate(recipeCount, (index) => fakeRecipe());
}
