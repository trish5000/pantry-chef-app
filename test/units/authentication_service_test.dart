import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/authentication/models/authenticate_response.dart';
import 'package:pantry_chef_app/authentication/services/authentication_service.dart';
import 'package:pantry_chef_app/configuration/config_settings.dart';

import '../fakes/fake_classes.dart';
import '../fakes/mock_services.dart';

void main() {
  late AuthenticationService authService;
  late MockDio api = MockDio();
  late MockGoogleSignIn googleSignIn;

  setUp(() {
    api = MockDio();

    when(() => api.post('/auth/authenticate', data: any(named: 'data')))
        .thenAnswer(
      (_) {
        final response = MockResponse();
        final authResponse = AuthenticateResponse()
          ..accessToken = 'token'
          ..user = fakeUser;

        when(() => response.data).thenReturn(authResponse.toJson());
        return Future.value(response);
      },
    );

    googleSignIn = MockGoogleSignIn();
    final fakeAccount = FakeGoogleSignInAccount();
    when(() => googleSignIn.signIn()).thenAnswer(
      (invocation) => Future.value(fakeAccount),
    );
    when(() => googleSignIn.signOut()).thenAnswer(
      (invocation) => Future.value(fakeAccount),
    );

    authService = AuthenticationService(api: api, googleSignIn: googleSignIn);
  });

  test('calling getUser calls the correct api endpoint', () async {
    await authService.login();

    verify(() => api.post('/auth/authenticate', data: any(named: 'data')));
  });

  test('resolving authProvider succeeds', () {
    final container = ProviderContainer(overrides: [
      configSettingsProvider.overrideWithValue(MockConfigSettings())
    ]);
    final auth = container.read(authServiceProvider);

    expect(auth, isNot(isNull));
  });
}
