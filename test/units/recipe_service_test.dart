import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/recipes/services/recipe_service.dart';
import 'package:pantry_chef_app/recipes/models/recipe.dart';

import '../fakes/fake_classes.dart';
import '../fakes/mock_services.dart';

void main() {
  late RecipeService recipeService;
  late MockDio api = MockDio();

  setUp(() {
    api = MockDio();

    recipeService = RecipeService(api: api);

    when(() => api.post(any(that: matches(r'\/users/[0-9]/recipes')),
        data: any(named: 'data'))).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data).thenReturn(fakeRecipe().toJson());
        return response;
      },
    );

    when(() => api.get(
          any(that: matches(r'\/users/[0-9]/recipes')),
        )).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data)
            .thenReturn(fakeLibrary().map((e) => e.toJson()).toList());
        return response;
      },
    );

    when(() => api.put(any(that: matches(r'\/users/[0-9]/recipes')),
        data: any(named: 'data'))).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data).thenReturn(fakeRecipe().toJson());
        return response;
      },
    );

    when(() => api.delete(any(that: matches(r'\/users/[0-9]/recipes')),
        data: any(named: 'data'))).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data).thenReturn(fakeRecipe().toJson());
        return response;
      },
    );
  });

  test('add a recipe', () async {
    final recipe = await recipeService.addRecipe(fakeRecipeCreate());
    expect(recipe, isNot(isNull));
  });

  test('get recipe library', () async {
    final List<Recipe> foodItems = await recipeService.getRecipes();
    expect(foodItems, isNotEmpty);
  });

  test('update recipe', () async {
    final updatedRecipe = await recipeService.updateRecipe(fakeRecipe());
    expect(updatedRecipe, isNot(isNull));
  });

  test('delete recipe', () async {
    final res = await recipeService.deleteRecipe(fakeRecipe());
    expect(res, isNull);
  });

  test('resolving service from Provider', () {
    final container = ProviderContainer(overrides: const []);
    final recipeService = container.read(recipeServiceProvider);

    expect(recipeService, isNot(isNull));
  });
}
