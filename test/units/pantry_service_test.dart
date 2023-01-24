import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/configuration/config_settings.dart';
import 'package:pantry_chef_app/pantry/services/pantry_service.dart';

import '../fakes/fake_classes.dart';
import '../fakes/mock_services.dart';

void main() {
  late PantryService pantryService;
  late MockDio api = MockDio();

  setUp(() {
    api = MockDio();

    pantryService = PantryService(
      userContext: fakeUserContext,
      api: api,
    );

    when(() => api.post(any(that: matches(r'\/users/[0-9]/pantry_Items')),
        data: any(named: 'data'))).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data).thenReturn(fakePantryItem.toJson());
        return response;
      },
    );

    when(() => api.get(
          any(that: matches(r'\/users/[0-9]/pantry_Items')),
        )).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data)
            .thenReturn(fakePantry().map((e) => e.toJson()).toList());
        return response;
      },
    );

    when(() => api.put(any(that: matches(r'\/users/[0-9]/pantry_Items')),
        data: any(named: 'data'))).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data).thenReturn(fakePantryItem.toJson());
        return response;
      },
    );

    when(() => api.delete(any(that: matches(r'\/users/[0-9]/pantry_Items')),
        data: any(named: 'data'))).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data).thenReturn(fakePantryItem.toJson());
        return response;
      },
    );
  });

  test('adding to pantry', () async {
    final pantryItem = await pantryService.addToPantry(fakePantryItemCreate);
    expect(pantryItem, isNot(isNull));
  });

  test('getting pantry', () async {
    final pantryItems = await pantryService.getPantry();
    expect(pantryItems, isNotEmpty);
  });

  test('update pantry', () async {
    final updatedPantryItem =
        await pantryService.updatePantryItem(fakePantryItem);
    expect(updatedPantryItem, isNot(isNull));
  });

  test('delete pantry', () async {
    final res = await pantryService.deletePantryItem(fakePantryItem);
    expect(res, isNull);
  });

  test('resolving service from Provider', () {
    final mockConfigSettings = MockConfigSettings();
    final container = ProviderContainer(overrides: [
      configSettingsProvider.overrideWithValue(mockConfigSettings)
    ]);
    final pantryService = container.read(pantryServiceProvider);

    expect(pantryService, isNot(isNull));
  });
}
