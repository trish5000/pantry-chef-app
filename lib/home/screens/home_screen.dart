import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/home/models/recipe_suggestion.dart';
import 'package:pantry_chef_app/home/services/suggestion_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<RecipeSuggestion> recipeSuggestions = [];

  @override
  void initState() {
    super.initState();
    _fetchRecipeSuggestions();
  }

  Future _fetchRecipeSuggestions() async {
    final suggestionService = ref.read(suggestionServiceProvider);
    final results = await suggestionService.getRecipeSuggestions();

    setState(() {
      recipeSuggestions = results;
    });
  }

  Widget ingredientCard(int numIngredients) {
    return Expanded(
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(numIngredients.toString()),
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'ingredients needed',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget pantryCard(int numIngredients) {
    return Expanded(
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).highlightColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(numIngredients.toString()),
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'pantry items',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget suggestionItem(RecipeSuggestion suggestion) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(
            width: 92,
            child: Center(
              child: Text(
                suggestion.recipe.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          ingredientCard(
            suggestion.missingIngredients.length,
          ),
          pantryCard(
            suggestion.pantryItems.length,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("What should I cook today?")),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: recipeSuggestions.length,
          itemBuilder: (context, index) {
            return suggestionItem(recipeSuggestions[index]);
          },
        ),
      ),
    );
  }
}
