import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/configuration/api_client.dart';
import 'package:pantry_chef_app/pantry/models/pantry_item.dart';
import 'package:pantry_chef_app/pantry/models/pantry_item_create.dart';

class PantryService {
  final Dio api;
  final UserContext userContext;
  PantryService({required this.userContext, required this.api});

  Future<List<PantryItem>> getPantry() async {
    final userId = userContext.user!.id;
    final apiResponse = await api.get(
      '/users/$userId/pantry_Items',
    );
    final pantryItems = apiResponse.data
        .map<PantryItem>((item) => PantryItem.fromJson(item))
        .toList();
    return pantryItems;
  }

  Future<PantryItem> addToPantry(PantryItemCreate newPantryItem) async {
    final userId = userContext.user!.id;
    final apiResponse = await api.post(
      '/users/$userId/pantry_Items',
      data: newPantryItem.toJson(),
    );
    return PantryItem.fromJson(apiResponse.data);
  }

  Future<PantryItem> updatePantryItem(PantryItem pantryItem) async {
    final userId = userContext.user!.id;
    final apiResponse = await api.put(
      '/users/$userId/pantry_Items',
      data: pantryItem.toJson(),
    );
    return PantryItem.fromJson(apiResponse.data);
  }

  Future deletePantryItem(PantryItem pantryItem) async {
    final userId = userContext.user!.id;
    await api.delete(
      '/users/$userId/pantry_Items',
      data: pantryItem.toJson(),
    );
  }
}

final pantryServiceProvider = Provider(
  (ref) {
    final userContext = ref.watch(authProvider);
    final api = ref.watch(apiClientProvider);
    return PantryService(
      userContext: userContext,
      api: api,
    );
  },
);
