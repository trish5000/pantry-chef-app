import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/configuration/api_client.dart';
import 'package:pantry_chef_app/pantry/models/food_item.dart';
import 'package:pantry_chef_app/pantry/models/food_item_create.dart';

class PantryService {
  final Dio api;
  PantryService({required this.api});

  Future<List<FoodItem>> getPantry() async {
    // TODO add user context
    final apiResponse = await api.get('/users/1/food_items');
    final foodItems = apiResponse.data
        .map<FoodItem>((item) => FoodItem.fromJson(item))
        .toList();
    return foodItems;
  }

  Future<FoodItem> addToPantry(FoodItemCreate newFoodItem) async {
    final response = await api.post(
      '/users/1/food_items',
      data: newFoodItem.toJson(),
    );
    return FoodItem.fromJson(response.data);
  }

  Future<FoodItem> updateFoodItem(FoodItem foodItem) async {
    final response = await api.put(
      '/users/1/food_items',
      data: foodItem.toJson(),
    );
    return FoodItem.fromJson(response.data);
  }

  Future deleteFoodItem(FoodItem foodItem) async {
    await api.delete(
      '/users/1/food_items',
      data: foodItem.toJson(),
    );
  }
}

final pantryServiceProvider = Provider(
  (ref) {
    final api = ref.watch(apiClientProvider);
    return PantryService(api: api);
  },
);
