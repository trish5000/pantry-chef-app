import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/home/state/suggestion_filters.dart';

class HouseholdState {
  final int? size;
  HouseholdState({this.size});

  HouseholdState copywith({int? size}) {
    return HouseholdState(size: size ?? this.size);
  }
}

class HouseholdStateNotifier extends StateNotifier<HouseholdState> {
  SuggestionFiltersNotifier suggestionFiltersNotifier;
  HouseholdStateNotifier(
      HouseholdState initialState, this.suggestionFiltersNotifier)
      : super(initialState);

  void specifyHouseholdSize(int size) {
    state = state.copywith(size: size);
    suggestionFiltersNotifier.specifyServings(size.toDouble());
  }
}

final householdStateProvider =
    StateNotifierProvider<HouseholdStateNotifier, HouseholdState>((ref) {
  final initialState = HouseholdState();
  final suggestionFiltersNotifier =
      ref.read(suggestionFiltersProvider.notifier);

  return HouseholdStateNotifier(
    initialState,
    suggestionFiltersNotifier,
  );
});
