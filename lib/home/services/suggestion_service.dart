import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/configuration/api_client.dart';
import 'package:pantry_chef_app/home/models/recipe_suggestion.dart';
import 'package:pantry_chef_app/home/state/suggestion_filters.dart';

class SuggestionService {
  final Dio api;
  final UserContext userContext;
  SuggestionService({required this.userContext, required this.api});

  Future<List<RecipeSuggestion>> getRecipeSuggestions(
      SuggestionFilters? filters) async {
    final params = {
      'servings': filters?.servings,
    }..removeWhere((key, value) => value == null);

    final queryString = params.entries
        .map(
          (e) => '${e.key}=${e.value}',
        )
        .join('&');

    final userId = userContext.user!.id;
    final apiResponse =
        await api.get('/users/$userId/suggestions?$queryString');
    final recipeSuggestions = apiResponse.data
        .map<RecipeSuggestion>((r) => RecipeSuggestion.fromJson(r))
        .toList();
    return recipeSuggestions;
  }
}

final suggestionServiceProvider = Provider(
  (ref) {
    final userContext = ref.watch(authProvider);
    final api = ref.watch(apiClientProvider);
    return SuggestionService(
      userContext: userContext,
      api: api,
    );
  },
);
