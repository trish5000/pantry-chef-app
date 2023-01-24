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

  Widget suggestionCard(RecipeSuggestion suggestion) {
    List<String> ingredients = suggestion.missingIngredients
        .map<String>((e) => "- ${e.quantity} ${e.unit} ${e.name}\n")
        .toList();
    return Card(
      child: ListTile(
        title: Text(suggestion.recipe.name),
        subtitle: Text(
            '${suggestion.missingIngredients.length} ingredients needed:\n\n${ingredients.join()}'),
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
            return suggestionCard(recipeSuggestions[index]);
          },
        ),
      ),
    );
  }
}
