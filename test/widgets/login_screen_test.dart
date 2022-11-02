import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/authentication/models/authenticate_response.dart';
import 'package:pantry_chef_app/authentication/screens/login.dart';
import 'package:pantry_chef_app/authentication/services/authentication_service.dart';

import '../fakes/fake_classes.dart';
import '../fakes/mock_services.dart';
import 'simple_material_app_widget.dart';

void main() {
  late MockAuthenticationService authService;

  setUpAll(() {
    authService = MockAuthenticationService();
  });

  testWidgets('Log in screen - render smoke test', (WidgetTester tester) async {
    when(() => authService.login()).thenAnswer(
      (_) async => AuthenticateResponse()
        ..user = fakeUser
        ..accessToken = 'token',
    );

    await tester.pumpWidget(
      SimpleMaterialAppWidget(
        overrides: [authServiceProvider.overrideWithValue(authService)],
        child: const LoginScreen(),
      ),
    );

    final loginButton = find.byType(ElevatedButton);
    await tester.tap(loginButton);

    verify(() => authService.login());
    await tester.pumpAndSettle();
  });
}
