import 'package:faker/faker.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/pantry/models/food_item.dart';
import 'package:pantry_chef_app/pantry/models/pantry_item_create.dart';
import 'package:pantry_chef_app/profile/models/household_member.dart';
import 'package:pantry_chef_app/profile/models/household_member_create.dart';
import 'package:pantry_chef_app/recipes/models/recipe.dart';
import 'package:pantry_chef_app/recipes/models/recipe_create.dart';
import 'package:pantry_chef_app/user/models/user.dart';

final _faker = Faker();

PantryItem get fakePantryItem => PantryItem()
  ..name = _faker.lorem.word()
  ..quantity = _faker.randomGenerator.decimal()
  ..unit = _faker.lorem.word()
  ..dateAdded = _faker.date.dateTime()
  ..useBy = _faker.date.dateTime()
  ..storageLocation = _faker.randomGenerator.element(StorageLocation.values);

PantryItemCreate get fakePantryItemCreate => PantryItemCreate()
  ..name = _faker.lorem.word()
  ..quantity = _faker.randomGenerator.decimal()
  ..unit = _faker.lorem.word()
  ..dateAdded = _faker.date.dateTime()
  ..useBy = _faker.date.dateTime()
  ..storageLocation = _faker.randomGenerator.element(StorageLocation.values);

List<PantryItem> fakePantry() {
  final pantryItemCount = _faker.randomGenerator.integer(300, min: 1);
  return List<PantryItem>.generate(pantryItemCount, (index) => fakePantryItem);
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

User get fakeUser => User()
  ..firstName = _faker.person.firstName()
  ..lastName = _faker.person.lastName()
  ..email = _faker.internet.email();

UserContext get fakeUserContext => UserContext()
  ..token = 'test'
  ..user = fakeUser;

HouseholdMemberCreate get fakeHouseholdMemberCreate =>
    HouseholdMemberCreate()..firstName = _faker.person.firstName();

HouseholdMember get fakeHouseholdMember => HouseholdMember()
  ..firstName = _faker.person.firstName()
  ..lastName = _faker.person.lastName()
  ..child = _faker.randomGenerator.boolean()
  ..dietaryPreferences = [];

List<HouseholdMember> fakeHousehold() {
  final memberCount = _faker.randomGenerator.integer(50, min: 1);
  return List<HouseholdMember>.generate(
      memberCount, (index) => fakeHouseholdMember);
}
