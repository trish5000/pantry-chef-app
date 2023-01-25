import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/home/models/recipe_suggestion.dart';
import 'package:pantry_chef_app/home/services/suggestion_service.dart';
import 'package:pantry_chef_app/home/state/suggestion_filters.dart';
import 'package:pantry_chef_app/profile/services/household_service.dart';
import 'package:pantry_chef_app/profile/state/household.dart';

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

  Future _fetchRecipeSuggestions({SuggestionFilters? filters}) async {
    // Get household size, which is default for number of servings
    // TODO use shared preferences instead?
    final householdState = ref.read(householdStateProvider);
    if (householdState.size == null) {
      final householdService = ref.read(householdServiceProvider);
      final members = await householdService.getHousehold();

      final householdState = HouseholdState(size: members.length);
      ref.read(householdStateProvider.notifier).update((_) => householdState);
      final suggestionFiltersNotifier =
          ref.read(suggestionFiltersProvider.notifier);
      suggestionFiltersNotifier.specifyServings(members.length.toDouble());
    }

    final suggestionService = ref.read(suggestionServiceProvider);
    final results = await suggestionService.getRecipeSuggestions(filters);

    if (!mounted) return;

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
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13),
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
                const Text(
                  'uses',
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(width: 8),
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
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget suggestionItem(RecipeSuggestion suggestion) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Center(
            child: Text(
              suggestion.recipe.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        const SizedBox(width: 8),
        ingredientCard(
          suggestion.missingIngredients.length,
        ),
        pantryCard(
          suggestion.pantryItems.length,
        )
      ],
    );
  }

  Widget filters() {
    return Container(
      color: Theme.of(context).focusColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        child: Row(
          children: [
            numServingsFilter(),
          ],
        ),
      ),
    );
  }

  Widget numServingsFilter() {
    final suggestionFilters = ref.watch(suggestionFiltersProvider);

    return Row(children: [
      decrementServingsButton(),
      const SizedBox(width: 4),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).cardColor),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            '${suggestionFilters.servings} servings',
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
      const SizedBox(width: 3),
      incrementServingsButton(),
    ]);
  }

  Widget incrementServingsButton() {
    return GestureDetector(
      onTap: () async {
        final suggestionFiltersNotifier =
            ref.read(suggestionFiltersProvider.notifier);
        suggestionFiltersNotifier.incrementServings();
      },
      child: const Icon(Icons.add),
    );
  }

  Widget decrementServingsButton() {
    return GestureDetector(
      onTap: () async {
        final suggestionFiltersNotifier =
            ref.read(suggestionFiltersProvider.notifier);
        suggestionFiltersNotifier.decrementServings();
      },
      child: const Icon(Icons.remove),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SuggestionFilters>(suggestionFiltersProvider,
        (previous, next) => _fetchRecipeSuggestions(filters: next));

    return Scaffold(
      appBar: AppBar(title: const Text("What should I cook today?")),
      body: Column(
        children: [
          filters(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      itemCount: recipeSuggestions.length,
                      itemBuilder: (context, index) {
                        return suggestionItem(recipeSuggestions[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
