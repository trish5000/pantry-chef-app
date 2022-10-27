import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/pantry/services/pantry_service.dart';

import '../fakes/fake_classes.dart';
import '../fakes/mock_services.dart';

void main() {
  late PantryService pantryService;
  late MockDio api = MockDio();

  setUp(() {
    api = MockDio();

    pantryService = PantryService(api: api);

    when(() => api.post(any(that: matches(r'\/users/[0-9]/food_items')),
        data: any(named: 'data'))).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data).thenReturn(fakeFoodItem.toJson());
        return response;
      },
    );

    when(() => api.get(
          any(that: matches(r'\/users/[0-9]/food_items')),
        )).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data)
            .thenReturn(fakePantry().map((e) => e.toJson()).toList());
        return response;
      },
    );

    when(() => api.put(any(that: matches(r'\/users/[0-9]/food_items')),
        data: any(named: 'data'))).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data).thenReturn(fakeFoodItem.toJson());
        return response;
      },
    );

    when(() => api.delete(any(that: matches(r'\/users/[0-9]/food_items')),
        data: any(named: 'data'))).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data).thenReturn(fakeFoodItem.toJson());
        return response;
      },
    );
  });

  test('adding to pantry', () async {
    final foodItem = await pantryService.addToPantry(fakeFoodItemCreate);
    expect(foodItem, isNot(isNull));
  });

  test('getting pantry', () async {
    final foodItems = await pantryService.getPantry();
    expect(foodItems, isNotEmpty);
  });

  test('update pantry', () async {
    final updatedFoodItem = await pantryService.updateFoodItem(fakeFoodItem);
    expect(updatedFoodItem, isNot(isNull));
  });

  test('delete pantry', () async {
    final res = await pantryService.deleteFoodItem(fakeFoodItem);
    expect(res, isNull);
  });

  test('resolving service from Provider', () {
    final container = ProviderContainer(overrides: const []);
    final pantryService = container.read(pantryServiceProvider);

    expect(pantryService, isNot(isNull));
  });
}
