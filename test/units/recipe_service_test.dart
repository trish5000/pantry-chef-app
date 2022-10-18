import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/recipes/services/recipe_service.dart';
import 'package:pantry_chef_app/recipes/models/recipe.dart';
import 'package:pantry_chef_app/recipes/models/recipe_create.dart';

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
        when(() => response.data).thenReturn({fakeRecipe().toJson()});
        return response;
      },
    );
  });

  test('adding to pantry', () async {
    final recipe = await recipeService.addRecipe(fakeRecipeCreate());
    print('RECIPEEEEEEEE EEE = $recipe');
    expect(recipe, isNot(isNull));
  });

  // test('getting pantry', () async {
  //   final foodItems = await recipeService.getPantry();
  //   expect(foodItems, isNotEmpty);
  // });

  test('resolving service from Provider', () {
    final container = ProviderContainer(overrides: const []);
    final recipeService = container.read(recipeServiceProvider);

    expect(recipeService, isNot(isNull));
  });
}
