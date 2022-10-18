import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/pantry/services/pantry_service.dart';
import 'package:pantry_chef_app/recipes/services/recipe_service.dart';

class MockPantryService extends Mock implements PantryService {}

class MockRecipeService extends Mock implements RecipeService {}

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}
