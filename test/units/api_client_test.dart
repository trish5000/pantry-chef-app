import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/configuration/api_client.dart';
import 'package:pantry_chef_app/configuration/config_settings.dart';

import '../fakes/fake_classes.dart';
import '../fakes/mock_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('resolving api client Provider', () {
    final mockAuthProvider =
        StateNotifierProvider<UserContextNotifier, UserContext>(
      (ref) => UserContextNotifier()..logIn(fakeUser, 'fakeToken'),
    );

    final container = ProviderContainer(overrides: [
      configSettingsProvider.overrideWithValue(MockConfigSettings()),
      authProvider.overrideWithProvider(mockAuthProvider)
    ]);
    final apiClient = container.read(apiClientProvider);

    expect(apiClient, isNot(isNull));
    expect(apiClient.options.headers.keys, contains('Authorization'));
  });
}
