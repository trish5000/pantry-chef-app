import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/configuration/api_client.dart';
import 'package:pantry_chef_app/recipes/models/recipe.dart';
import 'package:pantry_chef_app/recipes/models/recipe_create.dart';

class RecipeService {
  final Dio api;
  final UserContext userContext;
  RecipeService({required this.userContext, required this.api});

  Future<List<Recipe>> getRecipes() async {
    final apiResponse = await api.get('/users/1/recipes');
    final recipes =
        apiResponse.data.map<Recipe>((r) => Recipe.fromJson(r)).toList();
    return recipes;
  }

  Future<Recipe> addRecipe(RecipeCreate newRecipe) async {
    final userId = userContext.user!.id;
    final response = await api.post(
      '/users/$userId/recipes',
      data: newRecipe.toJson(),
    );
    return Recipe.fromJson(response.data);
  }

  Future<Recipe> updateRecipe(Recipe recipe) async {
    final userId = userContext.user!.id;
    final response = await api.put(
      '/users/$userId/recipes',
      data: recipe.toJson(),
    );
    return Recipe.fromJson(response.data);
  }

  Future deleteRecipe(Recipe recipe) async {
    final userId = userContext.user!.id;
    await api.delete(
      '/users/$userId/recipes',
      data: recipe.toJson(),
    );
  }
}

final recipeServiceProvider = Provider(
  (ref) {
    final userContext = ref.watch(authProvider);
    final api = ref.watch(apiClientProvider);
    return RecipeService(
      userContext: userContext,
      api: api,
    );
  },
);
