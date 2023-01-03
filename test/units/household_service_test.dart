import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/configuration/config_settings.dart';
import 'package:pantry_chef_app/profile/services/household_service.dart';

import '../fakes/fake_classes.dart';
import '../fakes/mock_services.dart';

void main() {
  late HouseholdService householdService;
  late UserContext userContext;
  late MockDio api = MockDio();

  setUp(() {
    api = MockDio();
    userContext = fakeUserContext;

    householdService = HouseholdService(
      userContext: userContext,
      api: api,
    );

    final userId = userContext.user!.id;

    when(() => api.post(any(that: matches(r'\/users/[0-9]/household')),
        data: any(named: 'data'))).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data).thenReturn(fakeHouseholdMember.toJson());
        return response;
      },
    );

    final household = fakeHousehold();
    final userIndex = household.indexWhere((m) => m.userId == userId);
    if (userIndex == -1) {
      final member = fakeHouseholdMember;
      member.userId = userId;
      household.add(member);
    }

    when(() => api.get(
          any(that: matches(r'\/users/[0-9]/household')),
        )).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data)
            .thenReturn(household.map((e) => e.toJson()).toList());
        return response;
      },
    );

    when(() => api.put(any(that: matches(r'\/users/[0-9]/household')),
        data: any(named: 'data'))).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data).thenReturn(fakeHouseholdMember.toJson());
        return response;
      },
    );

    when(() => api.delete(any(that: matches(r'\/users/[0-9]/household')),
        data: any(named: 'data'))).thenAnswer(
      (_) async {
        final response = MockResponse();
        when(() => response.data).thenReturn(fakeHouseholdMember.toJson());
        return response;
      },
    );
  });

  test('adding to household', () async {
    final member = await householdService.addMember(fakeHouseholdMemberCreate);
    expect(member, isNot(isNull));
  });

  test('getting household', () async {
    final household = await householdService.getHousehold();
    expect(household, isNotEmpty);
  });

  test('update household member', () async {
    final updatedHouseholdMember =
        await householdService.updateHouseholdMember(fakeHouseholdMember);
    expect(updatedHouseholdMember, isNot(isNull));
  });

  test('remove household member', () async {
    final res =
        await householdService.removeHouseholdMember(fakeHouseholdMember);
    expect(res, isNull);
  });

  test('resolving service from Provider', () {
    final mockConfigSettings = MockConfigSettings();
    final container = ProviderContainer(overrides: [
      configSettingsProvider.overrideWithValue(mockConfigSettings)
    ]);
    final householdService = container.read(householdServiceProvider);

    expect(householdService, isNot(isNull));
  });
}
