import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SuggestionFilters {
  double servings;
  SuggestionFilters(this.servings);

  SuggestionFilters copywith({
    double? servings,
  }) {
    return SuggestionFilters(servings ?? this.servings);
  }
}

class SuggestionFiltersNotifier extends StateNotifier<SuggestionFilters> {
  SuggestionFiltersNotifier(SuggestionFilters initialState)
      : super(initialState);

  void specifyServings(double servings) {
    state = state.copywith(servings: servings);
  }

  void incrementServings() {
    state = state.copywith(servings: state.servings + 1);
  }

  void decrementServings() {
    state = state.copywith(servings: max(state.servings - 1, 0.5));
  }

  void reset() {
    // Also TODO here
    state = SuggestionFilters(1.0);
  }
}

final suggestionFiltersProvider =
    StateNotifierProvider<SuggestionFiltersNotifier, SuggestionFilters>((ref) {
  // TODO read the initial state from a household state provider
  final initialState = SuggestionFilters(1.0);
  return SuggestionFiltersNotifier(initialState);
});
