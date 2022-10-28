import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/configuration/api_client.dart';
import 'package:pantry_chef_app/pantry/models/food_item.dart';
import 'package:pantry_chef_app/pantry/models/food_item_create.dart';

class PantryService {
  final Dio api;
  final UserContext userContext;
  PantryService({required this.userContext, required this.api});

  Future<List<FoodItem>> getPantry() async {
    final userId = userContext.user!.id;
    final apiResponse = await api.get(
      '/users/$userId/food_items',
    );
    final foodItems = apiResponse.data
        .map<FoodItem>((item) => FoodItem.fromJson(item))
        .toList();
    return foodItems;
  }

  Future<FoodItem> addToPantry(FoodItemCreate newFoodItem) async {
    final userId = userContext.user!.id;
    final response = await api.post(
      '/users/$userId/food_items',
      data: newFoodItem.toJson(),
    );
    return FoodItem.fromJson(response.data);
  }

  Future<FoodItem> updateFoodItem(FoodItem foodItem) async {
    final userId = userContext.user!.id;
    final response = await api.put(
      '/users/$userId/food_items',
      data: foodItem.toJson(),
    );
    return FoodItem.fromJson(response.data);
  }

  Future deleteFoodItem(FoodItem foodItem) async {
    final userId = userContext.user!.id;
    await api.delete(
      '/users/$userId/food_items',
      data: foodItem.toJson(),
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
