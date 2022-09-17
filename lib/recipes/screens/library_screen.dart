import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/recipes/models/recipe.dart';
import 'package:pantry_chef_app/recipes/services/recipe_service.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  List<Recipe> recipes = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future _fetchRecipes() async {
    loading = true;
    final recipeService = ref.read(recipeServiceProvider);
    final results = await recipeService.getRecipes();

    setState(() {
      recipes = results;
      loading = false;
    });
  }

  Widget ingredientList(List<Ingredient> ingredients) {
    return Column(
      children: ingredients
          .map((e) => Text('${e.quantity} ${e.unit} ${e.name}'))
          .toList(),
    );
  }

  Widget recipeCard(Recipe recipe) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(recipe.name.toUpperCase()),
          const SizedBox(height: 20),
          ingredientList(recipe.ingredients),
          const SizedBox(height: 20),
          if (recipe.procedure != null) Text(recipe.procedure!),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LinearProgressIndicator()
        : Scaffold(
            appBar: AppBar(title: const Text("Recipe Library")),
            body: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(20),
              children: recipes.map((e) => recipeCard(e)).toList(),
            ),
          );
  }
}
